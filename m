Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BDBF567C0F
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 09:19:39 +1100 (EST)
Subject: Re: [Fwd: [Bug 7431] New: ohci1394 Oops after a rmmod/modprobe	cycle]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20061106165752.GA25595@aepfle.de>
References: <454DBFE7.3090800@s5r6.in-berlin.de>
	<1162724083.28571.235.camel@localhost.localdomain>
	<454DC985.2020203@s5r6.in-berlin.de> <20061106165752.GA25595@aepfle.de>
Content-Type: text/plain
Date: Tue, 07 Nov 2006 09:19:29 +1100
Message-Id: <1162851570.28571.361.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Gioele Barabucci <dev@gioelebarabucci.com>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-11-06 at 17:58 +0100, Olaf Hering wrote:
> On Sun, Nov 05, Stefan Richter wrote:
> 
> > Yes, PowerBook G3 Pismo seems affected.
> > https://bugzilla.novell.com/show_bug.cgi?id=115228
> 
> This patch does not help. Doing an ip link set dev eth0 up makes no
> difference.

What about trying to add a delay between the pmac clock code and the
init of the controller ? does that help ?

(You need to have a cable plug and the interface up for the power
management bits not to get in the way btw)

Ben.
