Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1E28D67A6F
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Apr 2005 09:50:34 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <jeacodv2z0.fsf@sykes.suse.de>
References: <425266E2.7060605@gmx.de>  <jeacodv2z0.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Wed, 06 Apr 2005 09:50:15 +1000
Message-Id: <1112745015.9568.72.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: [Fwd: Re: iBook G3 owners]
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I have the same problem.  I'm also seeing the same hang when the KDED
> Media Manager is running (independent of hal/dbus).  I believe the cause
> for this is that the ide subsystem wakes up too late, and the cdrom
> polling of hal or kded is resuming too early.

Yes, but that should not cause a hang... the ioctl should just be
blocked until the driver is resumed, though there must be some kind of
bug preventing that from working...

Ben.
