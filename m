Return-Path: <ak@suse.de>
Received: from mx2.suse.de (ns2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C3AEFDDE48
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 10:25:26 +1000 (EST)
Sender: ak@suse.de
To: David Miller <davem@davemloft.net>
Subject: Re: ioctl32: Unknown cmd
References: <Pine.LNX.4.62.0710161642200.20196@pademelon.sonytel.be>
	<200710162150.37636.arnd@arndb.de>
	<20071016.152404.35664335.davem@davemloft.net>
From: Andi Kleen <andi@firstfloor.org>
Date: 17 Oct 2007 02:25:20 +0200
In-Reply-To: <20071016.152404.35664335.davem@davemloft.net>
Message-ID: <p73wstmy4cv.fsf@crumb.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geert.Uytterhoeven@sonycom.com, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, arnd@arndb.de, jens.axboe@oracle.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Miller <davem@davemloft.net> writes:

> From: Arnd Bergmann <arnd@arndb.de>
> Date: Tue, 16 Oct 2007 21:50:35 +0200
> 
> > The one point where it is expected to have changed now is when you
> > try to do these ioctls on something that is not a block device. Are
> > you sure that the files you tried them on were created correctly?
> 
> Many many many programs do this exact sort of thing.
> 
> It is one of the bad aspects of moving the compat handling
> down into the file ops for a specific device.

When this happens one should add respective IGNORE_IOCTL()s to 
compat_ioctl.c

-Andi
