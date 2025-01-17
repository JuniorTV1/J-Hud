window.addEventListener('message', (event) => {
    const data = event.data;

    if (data.type === 'updateHUD') {
        document.getElementById('cash').textContent = `💵 Liquide : ${data.cash}$`;
        document.getElementById('bank').textContent = `🏦 Banque : ${data.bank}$`;
        document.getElementById('job').textContent = `🔧 Métier : ${data.job} - ${data.jobGrade}`;
    }
});
