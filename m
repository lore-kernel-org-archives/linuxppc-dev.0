Message-ID: <001101c2e185$e49f4ba0$370da8c0@aman>
From: "Aman" <aman@mistralsoftware.com>
To: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Serial Console disable/enable dynamically
Date: Mon, 3 Mar 2003 18:37:50 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All

 I have an custom board which has PPC 440GP as its processor. I have build a
kernel image and ramdisk to run on the custom board, which is running
fine.There is only one serial port in the board.
This serial port is used as the serial console. I wanted to disable and
enable the serial console dynamically,
whenever the serial console is disabled , I want to use the serial port for
other purposes. Can anybody suggest how to disable and enable dynamically?.

 Thanking you in advance
Regards
Aman


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
