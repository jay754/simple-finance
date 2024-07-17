import SwiftUI
import Combine

struct ContentView: View {
    var body: some View {
        TabView {
            FutureValueView()
                .tabItem {
                    Label("FV", systemImage: "dollarsign.circle")
                }
            PresentValueView()
                .tabItem {
                    Label("PV", systemImage: "banknote")
                }
            PeriodicPaymentView()
                .tabItem {
                    Label("PMT", systemImage: "creditcard")
                }
            InterestRateView()
                .tabItem {
                    Label("I/Y", systemImage: "percent")
                }
            NumberOfPeriodsView()
                .tabItem {
                    Label("N", systemImage: "calendar")
                }
        }
    }
}

class FinancialCalculatorViewModel: ObservableObject {
    @Published var presentValue: String = ""
    @Published var futureValue: String = ""
    @Published var periodicPayment: String = ""
    @Published var interestRate: String = ""
    @Published var numberOfPeriods: String = ""
    
    func calculateFutureValue() -> Double {
        guard let pv = Double(presentValue),
              let pmt = Double(periodicPayment),
              let rate = Double(interestRate),
              let n = Double(numberOfPeriods) else { return 0.0 }
        let r = rate / 100.0
        return pv * pow(1 + r, n) + pmt * (pow(1 + r, n) - 1) / r
    }
    
    func calculatePresentValue() -> Double {
        guard let fv = Double(futureValue),
              let rate = Double(interestRate),
              let n = Double(numberOfPeriods) else { return 0.0 }
        let r = rate / 100.0
        return fv / pow(1 + r, n)
    }
    
    func calculatePeriodicPayment() -> Double {
        guard let fv = Double(futureValue),
              let rate = Double(interestRate),
              let n = Double(numberOfPeriods) else { return 0.0 }
        let r = rate / 100.0
        return fv * r / (pow(1 + r, n) - 1)
    }
    
    func calculateInterestRate() -> Double {
        // Placeholder for the iterative method to solve for interest rate
        return 0.0
    }
    
    func calculateNumberOfPeriods() -> Double {
        guard let pv = Double(presentValue),
              let fv = Double(futureValue),
              let rate = Double(interestRate) else { return 0.0 }
        let r = rate / 100.0
        return log(fv / pv) / log(1 + r)
    }
}

struct FutureValueView: View {
    @StateObject private var viewModel = FinancialCalculatorViewModel()

    var body: some View {
        VStack {
            Text("Simple Finance")
                .font(.largeTitle)
                .padding()
            Form {
                HStack {
                    Text("Present Value (PV):")
                    TextField("PV", text: $viewModel.presentValue)
                        .keyboardType(.decimalPad)
                }
                HStack {
                    Text("Periodic Payment (PMT):")
                    TextField("PMT", text: $viewModel.periodicPayment)
                        .keyboardType(.decimalPad)
                }
                HStack {
                    Text("Interest Rate (I/Y):")
                    TextField("I/Y", text: $viewModel.interestRate)
                        .keyboardType(.decimalPad)
                }
                HStack {
                    Text("Number of Periods (N):")
                    TextField("N", text: $viewModel.numberOfPeriods)
                        .keyboardType(.decimalPad)
                }
                HStack {
                    Text("Future Value (FV):")
                    Text("\(viewModel.calculateFutureValue(), specifier: "%.2f")")
                }
            }
            .padding()
        }
    }
}

struct PresentValueView: View {
    @StateObject private var viewModel = FinancialCalculatorViewModel()

    var body: some View {
        VStack {
            Text("Simple Finance")
                .font(.largeTitle)
                .padding()
            Form {
                HStack {
                    Text("Future Value (FV):")
                    TextField("FV", text: $viewModel.futureValue)
                        .keyboardType(.decimalPad)
                }
                HStack {
                    Text("Interest Rate (I/Y):")
                    TextField("I/Y", text: $viewModel.interestRate)
                        .keyboardType(.decimalPad)
                }
                HStack {
                    Text("Number of Periods (N):")
                    TextField("N", text: $viewModel.numberOfPeriods)
                        .keyboardType(.decimalPad)
                }
                HStack {
                    Text("Present Value (PV):")
                    Text("\(viewModel.calculatePresentValue(), specifier: "%.2f")")
                }
            }
            .padding()
        }
    }
}

struct PeriodicPaymentView: View {
    @StateObject private var viewModel = FinancialCalculatorViewModel()

    var body: some View {
        VStack {
            Text("Simple Finance")
                .font(.largeTitle)
                .padding()
            Form {
                HStack {
                    Text("Future Value (FV):")
                    TextField("FV", text: $viewModel.futureValue)
                        .keyboardType(.decimalPad)
                }
                HStack {
                    Text("Interest Rate (I/Y):")
                    TextField("I/Y", text: $viewModel.interestRate)
                        .keyboardType(.decimalPad)
                }
                HStack {
                    Text("Number of Periods (N):")
                    TextField("N", text: $viewModel.numberOfPeriods)
                        .keyboardType(.decimalPad)
                }
                HStack {
                    Text("Periodic Payment (PMT):")
                    Text("\(viewModel.calculatePeriodicPayment(), specifier: "%.2f")")
                }
            }
            .padding()
        }
    }
}

struct InterestRateView: View {
    @StateObject private var viewModel = FinancialCalculatorViewModel()

    var body: some View {
        VStack {
            Text("Simple Finance")
                .font(.largeTitle)
                .padding()
            Form {
                HStack {
                    Text("Present Value (PV):")
                    TextField("PV", text: $viewModel.presentValue)
                        .keyboardType(.decimalPad)
                }
                HStack {
                    Text("Future Value (FV):")
                    TextField("FV", text: $viewModel.futureValue)
                        .keyboardType(.decimalPad)
                }
                HStack {
                    Text("Number of Periods (N):")
                    TextField("N", text: $viewModel.numberOfPeriods)
                        .keyboardType(.decimalPad)
                }
                HStack {
                    Text("Interest Rate (I/Y):")
                    Text("\(viewModel.calculateInterestRate(), specifier: "%.2f")")
                }
            }
            .padding()
        }
    }
}

struct NumberOfPeriodsView: View {
    @StateObject private var viewModel = FinancialCalculatorViewModel()

    var body: some View {
        VStack {
            Text("Simple Finance")
                .font(.largeTitle)
                .padding()
            Form {
                HStack {
                    Text("Present Value (PV):")
                    TextField("PV", text: $viewModel.presentValue)
                        .keyboardType(.decimalPad)
                }
                HStack {
                    Text("Future Value (FV):")
                    TextField("FV", text: $viewModel.futureValue)
                        .keyboardType(.decimalPad)
                }
                HStack {
                    Text("Interest Rate (I/Y):")
                    TextField("I/Y", text: $viewModel.interestRate)
                        .keyboardType(.decimalPad)
                }
                HStack {
                    Text("Number of Periods (N):")
                    Text("\(viewModel.calculateNumberOfPeriods(), specifier: "%.2f")")
                }
            }
            .padding()
        }
    }
}

@main
struct FinancialCalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
