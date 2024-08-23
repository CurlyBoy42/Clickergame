<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Кликер Игра</title>
    <style>
        body {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            background: url('https://baldezh.top/uploads/posts/2022-08/1659774659_55-funart-pro-p-pikselnii-fon-les-krasivo-62.jpg') no-repeat center center fixed;
            background-size: cover;
            font-family: Arial, sans-serif;
            color: #fff;
        }

        .container {
            position: relative;
            display: flex;
            justify-content: space-between;
            width: 90%;
            height: 90%;
            max-width: 1200px;
        }

        #shop, #helpers {
            background-color: rgba(0, 0, 0, 0.7);
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            width: 200px;
            position: relative;
            z-index: 1;
        }

        #shop {
            flex-shrink: 0;
        }

        #helpers {
            flex-shrink: 0;
        }

        button {
            padding: 15px;
            font-size: 18px;
            background-color: #e74c3c;
            color: #fff;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.3s;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            margin-top: 10px;
            width: 100%;
        }

        button:active {
            transform: scale(0.95);
        }

        button:disabled {
            background-color: #bdc3c7;
            cursor: not-allowed;
        }

        #clickButton {
            font-size: 24px;
            background-color: #3498db;
            margin: auto;
            display: block;
        }

        #score {
            margin: 20px;
            font-size: 32px;
            text-align: center;
        }

        .main-content {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            flex-grow: 1;
        }

        .main-content > * {
            margin: 5px;
        }

        .helper {
            margin: 10px 0;
        }

        .helper img {
            width: 50px;
            height: 50px;
        }

        .locked img {
            opacity: 0.3;
        }
    </style>
</head>
<body>
    <div class="container">
        <div id="shop">
            <h2>Магазин</h2>
            <button id="upgradeButton">Улучшение (10 очков)</button>
            <button id="helperButton">Купить Диппера (50 очков)</button>
            <button id="upgradeHelperButton" disabled>Улучшить Диппера (100 очков)</button>
            <button id="elfButton" disabled>Купить Мейбл (500 очков)</button>
            <button id="upgradeElfButton" disabled>Улучшить Мейбл (1000 очков)</button>
        </div>
        <div class="main-content">
            <div id="score">Счет: 0</div>
            <button id="clickButton">Клик!</button>
        </div>
        <div id="helpers">
            <h2>Помощники</h2>
            <div id="gnomeHelper" class="helper">
                <img src="https://64.media.tumblr.com/9fb97e5c0265be2ee3cda8e7456894e6/tumblr_os14bj4nus1u6w1edo5_100.gifv" alt="Диппер">
                <span>Дипперов: <span id="gnomeCount">0</span></span>
            </div>
            <div id="elfHelper" class="helper locked">
                <img src="https://i.pinimg.com/originals/03/97/12/0397121d5e963c2eb0cdbd4c49a9bfbc.gif" alt="Мейбл">
                <span>Мейбл: <span id="elfCount">0</span></span>
            </div>
        </div>
    </div>
    <script>
        let score = 0;
        let clickValue = 1;
        let upgradeCost = 10;
        let gnomeCost = 50;
        let gnomeLevel = 0;
        let gnomeIncome = 1;
        let elfUnlocked = false;
        let elfCost = 500;
        let elfLevel = 0;
        let elfIncome = 10;
        let elfUpgradeCost = 1000;

        const scoreDisplay = document.getElementById('score');
        const clickButton = document.getElementById('clickButton');
        const upgradeButton = document.getElementById('upgradeButton');
        const helperButton = document.getElementById('helperButton');
        const upgradeHelperButton = document.getElementById('upgradeHelperButton');
        const elfButton = document.getElementById('elfButton');
        const upgradeElfButton = document.getElementById('upgradeElfButton');
        const gnomeHelper = document.getElementById('gnomeHelper');
        const gnomeCount = document.getElementById('gnomeCount');
        const elfHelper = document.getElementById('elfHelper');
        const elfCount = document.getElementById('elfCount');

        function updateScoreDisplay() {
            scoreDisplay.textContent = `Счет: ${score}`;
            upgradeButton.textContent = `Улучшение (${upgradeCost} очков)`;
            helperButton.textContent = `Купить Диппера (${gnomeCost} очков)`;
            upgradeHelperButton.textContent = `Улучшить Диппера (${gnomeLevel * 100} очков)`;
            elfButton.textContent = `Купить Мейбл (${elfCost} очков)`;
            upgradeElfButton.textContent = `Улучшить Мейбл (${elfUpgradeCost} очков)`;
        }

        function updateButtons() {
            upgradeButton.disabled = score < upgradeCost;
            helperButton.disabled = score < gnomeCost;
            upgradeHelperButton.disabled = score < gnomeLevel * 100;
            elfButton.disabled = !elfUnlocked || score < elfCost;
            upgradeElfButton.disabled = elfLevel === 0 || score < elfUpgradeCost;
        }

        clickButton.addEventListener('click', () => {
            score += clickValue;
            updateScoreDisplay();
            updateButtons();
        });

        upgradeButton.addEventListener('click', () => {
            if (score >= upgradeCost) {
                score -= upgradeCost;
                clickValue *= 2;
                upgradeCost *= 2;
                updateScoreDisplay();
                updateButtons();
            }
        });

        helperButton.addEventListener('click', () => {
            if (score >= gnomeCost) {
                score -= gnomeCost;
                gnomeLevel++;
                gnomeIncome *= 2;
                gnomeCost *= 2;
                updateScoreDisplay();
                updateButtons();

                gnomeCount.textContent = gnomeLevel;
                upgradeHelperButton.disabled = false;

                if (gnomeLevel >= 5) {
                    elfUnlocked = true;
                    elfHelper.classList.remove('locked');
                    elfButton.disabled = false;
                }
            }
        });

        upgradeHelperButton.addEventListener('click', () => {
            if (score >= gnomeLevel * 100) {
                score -= gnomeLevel * 100;
                gnomeIncome *= 2;
                updateScoreDisplay();
                updateButtons();
            }
        });

        elfButton.addEventListener('click', () => {
            if (score >= elfCost) {
                score -= elfCost;
                elfLevel++;
                elfIncome *= 2;
                elfCost *= 2;
                updateScoreDisplay();
                updateButtons();

                elfCount.textContent = elfLevel;
                upgradeElfButton.disabled = false;
            }
        });

        upgradeElfButton.addEventListener('click', () => {
            if (score >= elfUpgradeCost) {
                score -= elfUpgradeCost;
                elfIncome *= 2;
                elfUpgradeCost *= 2;
                updateScoreDisplay();
                updateButtons();
            }
        });

        setInterval(() => {
            score += gnomeIncome * gnomeLevel + elfIncome * elfLevel;
            updateScoreDisplay();
            updateButtons();
        }, 1000);
    </script>
</body>
</html>