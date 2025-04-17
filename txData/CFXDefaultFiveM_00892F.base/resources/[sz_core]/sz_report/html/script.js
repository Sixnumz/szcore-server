document.getElementById("sendReportBtn").addEventListener("click", () => {
    const text = document.getElementById("reportText").value;
  
    fetch(`https://${GetParentResourceName()}/sendReport`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ message: text })
    });
  });
  
  // แสดงผลลัพธ์จาก Lua
  window.addEventListener("message", (event) => {
    const data = event.data;
    if (data.type === "reportStatus") {
      document.getElementById("reportStatus").innerText = data.message;
      document.getElementById("reportText").value = ""; // ล้างฟอร์ม
    }
  });
  