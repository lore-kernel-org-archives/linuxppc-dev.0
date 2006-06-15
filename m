Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 0608F67B5D
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 13:27:43 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k5F3cOMX007678
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jun 2006 20:38:24 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k5F3Rcwv011835
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jun 2006 22:27:40 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD467306A5F987@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Adrian Cox <adrian@humboldt.co.uk>
Subject: RE: [PATCH/2.6.17-rc4 8/10]  Add  tsi108 8250 serial support
Date: Thu, 15 Jun 2006 11:27:30 +0800
MIME-Version: 1.0
Content-Type: text/plain
Cc: Alexandre.Bounine@tundra.com, Russell King <rmk+lkml@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, linux-serial@vger.kernel.org,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Tue, 2006-06-13 at 13:39 +0800, Zang Roy-r61911 wrote:
> 
> > The reason is that the serial port on tsi108/9 is a bit difference 
> > with the standard 8250 serial port. the patch deal with the 
> difference.
> > The prefixed ">" is caused by "Fw" the email. Sorry for that. The 
> > following is the original patch.
> 
> The problem I see is that the code uses a CONFIG option, to 
> change the behaviour of the generic 8250 driver. What happens 
> if somebody adds a PCI serial card to a tsi108 based machine?

I do not like CONFIG option:). It might be a problem in the environment you suggesting.

> 
> Perhaps you should define a new value for 
> uart_8250_port.port.iotype, and add code to serial_in and 
> serial_out to handle the IIR register.
I will consider it.
> 
> --
> Adrian Cox <adrian@humboldt.co.uk>
> 
