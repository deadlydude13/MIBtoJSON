const fs = require("fs");
const fileInput = document.getElementById("fileInput");
fileInput.addEventListener("change", (event) => {
    const file = event.target.files[0];
    const reader = new FileReader();
    // Set up the onload event handler
    reader.onload = (e) => {
        const content = e.target.result;
        const jsonData = JSON.parse(content);

        // Convert integers/numbers to strings
        const convertedData = JSON.stringify(jsonData, (key, value) => {
            if (typeof value === "number") {
                return value.toString();
            }
            return value;
        });
        // Write the converted data back to the file
        fs.writeFile("E:/MIBtoJSON/ConvertedJson.json", convertedData, "utf8", (err) => {
            if (err) {
                console.error(err);
                return;
            }
            console.log("Conversion completed successfully.");
        });
    };
    reader.readAsText(file);
});
