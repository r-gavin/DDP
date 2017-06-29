library(reshape2)
library(plotly)
library(ggplot2)

B_n <- function(u,x,y,z) {

      # u = A, x = i, y = n, z = P
      x <- x/12
      u*(1+x)^y-z/x*((1+x)^y-1)      
}


P_n <- function(u,x,y,z) {
      
      # u = A, x = i, y = n, z = P
#      x <- x/12
      
      p_pay <- (B_n(u,x,y-1,z) - B_n(u,x,y,z))
      i_pay <- z - p_pay

      c(p_pay,i_pay)
}

invest_func <- function(A,i_rate,temp) {

##    A = initial ammount, i_rate = interest rate, temp = investment payments every month      
      temp_uniq <- unique(temp)
      temp_nums <- apply(
            array(temp_uniq,c(1,length(temp_uniq))), 
            2, function(x) sum(temp == x)
            )

      temp_invest <- A
      
      for(i in 1:length(temp_uniq)) {
            temp_invest <- c(temp_invest,
                      B_n(temp_invest[length(temp_invest)],i_rate,1:
                                temp_nums[i],-temp_uniq[i]
                          )
            )
      }
      
      temp_invest
}

accum_interest <- function(temp) {
      test <- temp[1]
      
      for(i in 2:length(temp)) {
            test <- c(test,sum(temp[1:i]))
      }
      test
}

accum_interest2 <- function(temp1,temp2) {
      test <- 0
      
      for(i in 2:length(temp1)) {
            test <- c(test,temp1[i]-temp1[i-1]-temp2[i-1])
      }
      test
}

temp <- 1:10
test <- temp[1]

for(i in 2:length(temp)) {
      test <- c(test,sum(temp[1:i]))
}




ttt <- P_n(17000,0.018,1:60,297)
ttt_1 <- ttt[1:I(length(ttt)/2)]
ttt_2 <- ttt[I(length(ttt)/2 + 1):length(ttt)]
data.frame(principal_paid = ttt_1, interest_paid = ttt_2)

init_ammount <- 200
i_rate <- 0.05

temp <- c(0,rep(110,6),rep(225,5))
temp_uniq <- unique(temp)
temp_nums <- apply(
      array(temp_uniq,c(1,length(temp_uniq))), 
      2, 
      function(x) sum(temp == x)
      )

#test <- B_n(init_ammount,i_rate,1:temp_nums[1],-temp_uniq[1])
test <- init_ammount

for(i in 1:length(temp_uniq)) {
      test <- c(test,
                B_n(test[length(test)],i_rate,1:temp_nums[i],-temp_uniq[i])
                )
}

################################

stud_N <- 12
mnths <- 0:stud_N

i_paid_min <- 12:0
p_paid_min <- 100 - i_paid_min

i_paid <- 50:38
p_paid <- 150 - i_paid

w_min <- data.frame(
      month = mnths,
      prin = p_paid_min,
      interest = i_paid_min,
      type = "w_min")
wo_min <- data.frame(
      month = mnths,
      prin = p_paid,
      interest = i_paid,
      type = "wo_min")

w_min2 <- melt(w_min,id.vars = c("month","type"))
wo_min2 <- melt(wo_min,id.vars = c("month","type"))

temp <- rbind.data.frame(w_min,wo_min)
temp2 <- melt(temp,id.vars = c("month","type"))

p1 <- plot_ly(w_min2,x = ~month, y = ~value, color=~variable) %>%
      add_bars() %>%
      layout(barmode = "stack")

p2 <- plot_ly(wo_min2,x = ~month, y = ~value, color=~variable) %>%
      add_bars() %>%
      layout(barmode = "stack")
