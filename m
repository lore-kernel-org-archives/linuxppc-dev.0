Return-Path: <olaf@aepfle.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.182])
	by ozlabs.org (Postfix) with ESMTP id 1E57667C1C
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 18:08:43 +1100 (EST)
Date: Tue, 7 Nov 2006 08:08:36 +0100 (MET)
From: Olaf Hering <olaf@aepfle.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Fwd: [Bug 7431] New: ohci1394 Oops after a rmmod/modprobe	cycle]
Message-ID: <20061107070839.GA31460@aepfle.de>
References: <454DBFE7.3090800@s5r6.in-berlin.de>
	<1162724083.28571.235.camel@localhost.localdomain>
	<454DC985.2020203@s5r6.in-berlin.de>
	<20061106165752.GA25595@aepfle.de>
	<1162851570.28571.361.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1162851570.28571.361.camel@localhost.localdomain>
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

On Tue, Nov 07, Benjamin Herrenschmidt wrote:

> On Mon, 2006-11-06 at 17:58 +0100, Olaf Hering wrote:
> > On Sun, Nov 05, Stefan Richter wrote:
> > 
> > > Yes, PowerBook G3 Pismo seems affected.
> > > https://bugzilla.novell.com/show_bug.cgi?id=115228
> > 
> > This patch does not help. Doing an ip link set dev eth0 up makes no
> > difference.
> 
> What about trying to add a delay between the pmac clock code and the
> init of the controller ? does that help ?

no. and it is the rmmod, not the insmod, that hangs the pismo.
Adding some mdelay to the remove function doesnt help either.
