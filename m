Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <81A66F72DCACD511B0600002A551BFCB4E9CEC@kuumex05.barco.com>
From: =?iso-8859-1?Q?=22Callebaut=2C_Beno=EEt=22?= <benoit.callebaut@barco.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: IRQ config problem on MPC8245
Date: Tue, 17 Dec 2002 15:08:02 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Hello,
 I   have on a custom board a little problem with the IRQ configuration.
> Our board is a custom board derived from a sandpoint board X3B with a
> MPC8245 without any peripheral (no extern bridge, no IRQ controller,...)
> except 2 MAC/PHY 82449 from Intel and run Montavista Linux 2.1 based on a
> 2.4.18 Kernel
> The Interrupt lines from the MAC/PHY are directly connected to the
> interrupts inputs pins of the EPIC on the MPC8245.
> The EPIC is well configured (IVPR0,IVPR1, PCTPR,GCR,...)
> The Linux distribution is also modified to take this in account.
> The interrupts are generated on the EPIC (seen with an osilloscope and a
> register dump ).
> The interrupt handler is never called. There is no jump the address
> 0X00000500 (external interrupt exception vector )
> We ask ourselves what is the problem. We have seen that the value of the
> MSR[EE] bit change sometimesand that the value of MSR[IP] is well on null.
>
I know that such an question must be asked to Montavista support but such a
thing is beyond the standard support of Montavista (ie free after buying
their product)

- - - - - - - DISCLAIMER - - - - - - - -
Unless indicated otherwise, the information contained in this message is
privileged and confidential, and is intended only for the use of the
addressee(s) named above and others who have been specifically authorized to
receive it. If you are not the intended recipient, you are hereby notified
that any dissemination, distribution or copying of this message and/or
attachments is strictly prohibited. The company accepts no liability for any
damage caused by any virus transmitted by this email. Furthermore, the
company does not warrant a proper and complete transmission of this
information, nor does it accept liability for any delays. If you have
received this message in error, please contact the sender and delete the
message. Thank you.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
