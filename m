Return-Path: <batsayan.das@tcs.com>
To: Linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
From: batsayan.das@tcs.com
Message-ID: <OFDC66830E.1EDE14C4-ON652570F3.00265CDF-652570F3.00297A66@tcs.com>
Date: Wed, 11 Jan 2006 13:03:02 +0530
Content-Type: multipart/alternative;
	boundary="=_alternative 00297A21652570F3_="
Subject: Ethernet not initialized: Help req
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 00297A21652570F3_=
Content-Type: text/plain; charset="US-ASCII"


Hello,

In our MPC8260 based customs board the CLK9 is for transmit and CLK10 is 
for receive. The ELDK tree uses  CLK12 is receive, CLK11 is transmit and 
the corresponding values defined in as.

/* CLK12 is receive, CLK11 is transmit.  These are board specific.
*/
#define PC_F1RXCLK      ((uint)0x00000800)
#define PC_F1TXCLK      ((uint)0x00000400)


We got CLK9  and CLK10 from U-Boot tree and set those varables, but 
ethernet does not work. 

We are using LXT971 on FCC1, and setting MII_MDIO and MII_MDCK to our 
board specific value detects LXT971 correctly. Here is the log 

****LOG*****
GOT FCC IRQ 32

GOT MII IRQ 25

eth0: FCC1 ENET Version 0.4, 00:0B:17:00:00:00

eth0: Phy @ 0x0, type LXT971 (0x001378e2)
***************8

My question is what value shall I use for CLK9 and CLK10? 
What else setting we need to change to make Ethernet work?

Pls help.

Thanks,
Batsayan Das


Notice: The information contained in this e-mail message and/or attachments to it may contain confidential or privileged information.   If you are not the intended recipient, any dissemination, use, review, distribution, printing or copying of the information contained in this e-mail message and/or attachments to it are strictly prohibited.   If you have received this communication in error, please notify us by reply e-mail or telephone and immediately and permanently delete the message and any attachments.  Thank you
--=_alternative 00297A21652570F3_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hello,</font>
<br>
<br><font size=2 face="sans-serif">In our MPC8260 based customs board the
CLK9 is for transmit and CLK10 is for receive. The ELDK tree uses &nbsp;CLK12
is receive, CLK11 is transmit and the corresponding values defined in as.</font>
<br>
<br><font size=2 face="sans-serif">/* CLK12 is receive, CLK11 is transmit.
&nbsp;These are board specific.</font>
<br><font size=2 face="sans-serif">*/</font>
<br><font size=2 face="sans-serif">#define PC_F1RXCLK &nbsp; &nbsp; &nbsp;((uint)0x00000800)</font>
<br><font size=2 face="sans-serif">#define PC_F1TXCLK &nbsp; &nbsp; &nbsp;((uint)0x00000400)</font>
<br>
<br>
<br><font size=2 face="sans-serif">We got CLK9 &nbsp;and CLK10 from U-Boot
tree and set those varables, but ethernet does not work. </font>
<br>
<br><font size=2 face="sans-serif">We are using LXT971 on FCC1, and setting
MII_MDIO and MII_MDCK to our board specific value detects LXT971 correctly.
Here is the log </font>
<br>
<br><font size=2 face="sans-serif">****LOG*****</font>
<br><font size=2 face="Courier New">GOT FCC IRQ 32</font>
<br>
<br><font size=2 face="Courier New">GOT MII IRQ 25</font>
<br>
<br><font size=2 face="Courier New">eth0: FCC1 ENET Version 0.4, 00:0B:17:00:00:00</font>
<br>
<br><font size=2 face="Courier New">eth0: Phy @ 0x0, type LXT971 (0x001378e2)</font>
<br><font size=2 face="sans-serif">***************8</font>
<br>
<br><font size=2 face="sans-serif">My question is what value shall I use
for CLK9 and CLK10? </font>
<br><font size=2 face="sans-serif">What else setting we need to change
to make Ethernet work?</font>
<br>
<br><font size=2 face="sans-serif">Pls help.</font>
<br>
<br><font size=2 face="sans-serif">Thanks,</font>
<br><font size=2 face="sans-serif">Batsayan Das<br>
</font>
<table><tr><td bgcolor=#ffffff><font color=#000000>Notice: The information contained in this e-mail message and/or attachments to it may contain confidential or privileged information.   If you are not the intended recipient, any dissemination, use, review, distribution, printing or copying of the information contained in this e-mail message and/or attachments to it are strictly prohibited.   If you have received this communication in error, please notify us by reply e-mail or telephone and immediately and permanently delete the message and any attachments.  Thank you<br>
</font></td></tr></table>
--=_alternative 00297A21652570F3_=--
