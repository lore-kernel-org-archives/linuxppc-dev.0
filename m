Return-Path: <namaskar_alok@yahoo.co.in>
Message-ID: <20060724134454.90046.qmail@web8903.mail.in.yahoo.com>
Date: Mon, 24 Jul 2006 06:44:54 -0700 (PDT)
From: Alok Barsode <namaskar_alok@yahoo.co.in>
Subject: Query regarding Gianfar Ethernet Driver for MPC8555E
To: Linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,
I am a newbie, working on the MPC8555E(Freescale). 

The Gianfar Ethernet Driver configures the TSECs on
the board.I see that out of the 4 Ethernet Interfaces
only 2 are configured when the gianfar driver is
loaded(I have complied it as a modules).I checked this
via "ifconfig" command. Out of the 4 ports, 2 are
located on the basic carrier board and the other two
on the IOCard expansion.

I wonder why all four of them are not configured?

Thanks in advance,
Alok.


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
