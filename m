Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Support for MPC852T, any experience ?
Date: Tue, 17 Jun 2003 13:14:50 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200306171314.50574.david.jander@protonic.nl>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

We are developing a board based on the MPC852T (fairly new model,
stripped-down MPC866).
Is there anybody who has sucessfully run linux-ppc on this processor yet (or
it's more advanced MPC866 cousin) ?
Any experience ?
I am specifically interested in using the SPI mode for SCC3 or 4, plus FEC
with an LXT971A phy.
I am new to this mailing list, but I have searched through its archive and
came up with a (simple ?) SPI driver from Navin Bopurri.
Also on the DENX website I found their drivers for 8xx in the 2.4.4 kernel
sources. Has anybody ported those drivers to a more recent version ?
I have now managed to set up a cross-development system comiling the latest
binutils, gcc-3.2.3 (--with-newlib) and the latest linuxppc_2_4_devel kernel
from montavista. I have not been able to find an up to date guide for setting
up such a system (I had to sweat my own way through it). If there is such a
guide (the Howto's I could find seem hopelessly outdated), could someone
please provide a pointer ? Otherwise, I would be glad to offer my experience
from this point on for a FAQ or (somwhat more up-to-date) mini-howto. Any
ideas ?

Greetings,

--
David Jander
Protonic Holland.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
