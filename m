Content-Type: text/plain
MIME-Version: 1.0
Message-ID: <K7969592836898.23905@webmail5.inner-21cn.com>
Date: Mon, 7 Apr 2003 16:31:01 +0800 (CST)
From: "li" <slowforce@21cn.com>
To: linuxppc-embedded@lists.linuxppc.org
Cc: 
Subject: start kernel failed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,
i am running kernel 2.4.18(hhl) with XPC850SR and everything is ok. But if i modified the 8xx_immap.h, add "utmode" unit in the io_port struct, after booting the board with ppcboot and tftp the kernel image(zImage.embedded under arch/ppc/boot/images), i use go #address to boot image, the console output start application at #address...
and nothing happened more!
If i comment the utmode unit, everything got back!
Any advice is encouraged!
Regards!
Li


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
