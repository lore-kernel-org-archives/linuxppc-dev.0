From: "Kazuya Sakakihara" <kazuya@posedge.co.jp>
To: "Jennie Yuan" <jennie.yuan@fel.com.cn>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: ISDN support on 860T
Date: Sun, 9 Sep 2001 00:33:40 +0900
Message-ID: <JJECKOJGMMNKGLKFPPHPEEGHCCAA.kazuya@posedge.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
In-Reply-To: <003301c13772$73f01d80$52c809c0@john>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

> I have searched through all list, I did not
> find any exist code for ISDN4linux on 8xx.
> Here is my project:
>    XPC860T,
>    mc145574 IDL ISDN/BRI S/T
>    FEC for 100BASE-TX
>    SCC1 SCC2 SMC2 2B+D
> I wish IP over ISDN dial-up working on it.
> I am not expert, I know you guys are so kind,
> so,could you give me some advice?
> Shall we make it together?

Yeah, I ported an isdn4linux driver to a custom-made board with XPC860
for a company in Japan.
It works with PPP and Multilink PPP, but not tested with X.25.

The low-level driver is based on hisax, and should be GPL'ed.
But that system has an POTS port and driver for it is NOT GPL'ed.

You may request the source for the isdn4linux-based driver,
although it is for use with Japanese NTT INS64 network
(which is similar to European DSS).

I myself do not have the copyright of  the driver, so do not blame
me about open-sourceness of that.

--
Kazuya Sakakihara
Positive Edge Inc.
mailto:kazuya@posedge.co.jp / http://www.posedge.co.jp


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
