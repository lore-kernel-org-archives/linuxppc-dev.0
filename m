Message-Id: <200102091048.EAA18120@lists.linuxppc.org>
Date: Fri, 9 Feb 2001 11:31:47 +0800
From: cuidongwei <cuidw@sina.com>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: kernel panic when read from device driver
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,everyone,
	I am develop a device driver on our custom PPC823 board,the board has linux running on it and everything works well.The device is infact a 8bit fifo,I use CS5 to select it and read data from it,the Address which is selected by CS5 is begin at 0xfff00000.I use ioremap( ) function to read data from the address 0xfff00000,but kernel panic always occured.Does anyone can help me?Any comments would be appreciated.

Thanks,
Derek


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
