window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value
    const addTaxDom = document.getElementById("add-tax-price")
    const tax = 0.1
    const price = inputValue * tax
    addTaxDom.innerHTML = Math.floor(price)
    console.log(price)
    const salesProfit = document.getElementById("profit")  
    salesProfit.innerHTML = inputValue - Math.floor(price)
    console.log(salesProfit)

  })
});