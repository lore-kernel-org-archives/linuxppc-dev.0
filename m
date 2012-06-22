Return-Path: <list.mail.for.bill@gmail.com>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 07410B6FA3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jun 2012 05:14:50 +1000 (EST)
Received: by obbeh20 with SMTP id eh20so2260133obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2012 12:14:47 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 22 Jun 2012 15:14:47 -0400
Message-ID: <CAGa5=mPAVTtZuJ998wPdD6aHyZTn9TPRoaNkadh4yMUwvjTkpA@mail.gmail.com>
Subject: Help with Freescale QE ATM driver (FUA)
From: Bill F <list.mail.for.bill@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,
Have you used the Freescale QUICC Engine (QE) ATM mode with a Linux
based product ?

I am currently using the "fua" driver obtained from Freescale
MPC8360E_PB_K26_20081112-LTIB.iso CDROM image.  The "fua" driver was
written for kernel 2.6.22 (2007) and I have ported it forward to
kernel 3.3 (2012).  My board has an MPC8358 and SUNI PHY.  I am
testing the fua driver with the atm-tools and aburst, and using a
loopback cable.

The ported fua driver is able to open an ATM connection and send and
receive messages.  I can use awrite and aread to send and receive
ascii characters.

Problems:
  * If I open three or more ATM connections, all ATM transfers stop,
and the ethernet driver (ucc_geth) also stops working.  To recover I
have to reboot. Urg.
  * UBR transfers seem to be treated as if they are a 100 Mbps CBR
connection.  I was expecting UBR to fill all of the unused bandwidth.
  * I'm finding and fixing a lot of minor bugs that crash the driver.

My other reference is the mpc8360 SAR driver
(http://mpc8360sar.sourceforge.net) which is even older (patches
against kernel 2.6.11).

If someone on this list is sitting on an updated fua driver or similar
QE ATM driver, could you send me the code.  Better yet, can I help you
push it out to a github or similar repo ?

Thanks,
Bill
