Return-Path: <arsadri@yahoo.ca>
Received: from web12824.mail.yahoo.com (web12824.mail.yahoo.com
	[216.136.174.205]) by ozlabs.org (Postfix) with SMTP id C893B2BF0C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Dec 2004 23:59:15 +1100 (EST)
Message-ID: <20041215125233.99983.qmail@web12824.mail.yahoo.com>
Date: Wed, 15 Dec 2004 04:52:33 -0800 (PST)
From: Alireza Sadri <arsadri@yahoo.ca>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: kernel's booting hangs on SCC2
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi ,

i use kernel v2.4.24 , and i used make
menuconfig and for MPC8260 (custom EST8260 board) I
chosed SCC for console .

I have only one SCC1 port on my board (it has only two
pins Rx,Tx) but i cannot configure kernel to search
only for one console while booting, it hangs after
searching for the second SCC:

Uncompressing Kernel Image ... OK
Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.24-pre2 (root@Setareh2) (gcc version
...
...
...
Initializing RT netlink socket
Starting kswapd
CPM UART driver version 0.01
ttyS0 on SCC1 at 0x8000, BRG7
ttyS1 on SCC2

and hangs here  , can anyone please tell me what is my
problem? here is my menuconfig MPC8260 CPM
configuration:

[*] Enable SCC console
[ ] CPM SCC Ethernet
[*] CPM FCC Ethernet
[*] Ethernet on FCC1
[*] Ethernet on FCC2
[*] Ethernet on FCC3
[ ] Use MDIO for PHY configuration
[ ] Support LXT970    PHY
[*] Support LXT971    PHY
[ ] Support QS6612    PHY
[ ] Support AMD79C873 PHY
[ ] Support DM9131    PHY
[ ] Simple CPM SPI Support
--- SCC UART h/w handshaking options
---   SCC1
(None) CTS signal for SCC1
(None) RTS signal for SCC1
(None) CD signal for SCC1
(None) DTR signal port for SCC1
---   SCC2
(None) CTS signal for SCC2
(None) RTS signal for SCC2
(None) CD signal for SCC2
(None) DTR signal port for SCC2
---   SCC3
(None) CTS signal for SCC3
(None) RTS signal for SCC3
(None) CD signal for SCC3
(None) DTR signal port for SCC3
---  SCC4
(None) CTS signal for SCC4
(None) RTS signal for SCC4
(None) CD signal for SCC4
(None) DTR signal port for SCC4

Best regards,
Alireza Sadri


		
__________________________________ 
Do you Yahoo!? 
Take Yahoo! Mail with you! Get it on your mobile phone. 
http://mobile.yahoo.com/maildemo 
