# Input Parameters
loan_amount <- 25000  # Principal
annual_rate <- 5.33       # Annual interest rate in percent
years <- 5            # Loan term in years
start_date <- as.Date("2024-09-01")  # Start date of the loan (first payment date)

# Calculations
monthly_rate <- (annual_rate / 100) / 12
n_payments <- years * 12
monthly_payment <- loan_amount * (monthly_rate * (1 + monthly_rate)^n_payments) / ((1 + monthly_rate)^n_payments - 1)

# Initialize vectors for storing schedule details
schedule <- data.frame(
  Month = seq.Date(from = start_date, by = "month", length.out = n_payments),
  Payment = 1:n_payments,
  Interest = numeric(n_payments),
  Principal = numeric(n_payments),
  Balance = numeric(n_payments)
)

# Initial balance
balance <- loan_amount

# Populate the schedule
for (i in 1:n_payments) {
  interest_payment <- balance * monthly_rate
  principal_payment <- monthly_payment - interest_payment
  balance <- balance - principal_payment
  
  schedule$Interest[i] <- round(interest_payment, 2)
  schedule$Principal[i] <- round(principal_payment, 2)
  schedule$Balance[i] <- round(balance, 2)
}

# Add the monthly payment to the schedule
schedule$PaymentAmount <- round(monthly_payment, 2)

# Print the amortization schedule
print(schedule)

# Calculate the total interest paid
total_interest_paid <- sum(schedule$Interest)

print(paste("Total interest paid over the loan term: $", round(total_interest_paid, 2)))

# Calculate the total cost of the loan
total_loan_cost <- loan_amount + total_interest_paid

print(paste("Total cost of the loan: $", round(total_loan_cost, 2)))
