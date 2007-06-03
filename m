Return-Path: <bzolnier@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id 7F95BDDEFF
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 04:54:57 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id c2so605264ugf
	for <linuxppc-dev@ozlabs.org>; Sun, 03 Jun 2007 11:54:55 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Brad Boyer <flar@allandria.com>
Subject: Re: [PATCH] IDE: Remove remnants related to dead BLK_DEV_MAC_MEDIABAY
	CONFIG variable.
Date: Sun, 3 Jun 2007 21:07:52 +0200
References: <Pine.LNX.4.64.0706031348550.24843@localhost.localdomain>
	<20070603172829.GA25404@cynthia.pants.nu>
In-Reply-To: <20070603172829.GA25404@cynthia.pants.nu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706032107.52152.bzolnier@gmail.com>
Cc: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>,
	"Robert P. J. Day" <rpjday@mindspring.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

Ehm, I'm guilty for this mistake since I've advised Robert
to cc: wrong list (thinko caused by mediabay == ppc assumption).

Sorry for this. :)

Robert: I'll apply both patches in a few days if there are no
complains from m68k/scsi people.

Thanks,
Bart

On Sunday 03 June 2007, Brad Boyer wrote:
> On Sun, Jun 03, 2007 at 01:52:02PM -0400, Robert P. J. Day wrote:
> > Remove the two snippets of code conditional on the non-existent CONFIG
> > variable CONFIG_BLK_DEV_MAC_MEDIABAY.
> 
> This is the wrong list. The macide driver is for m68k Macintoshes, so
> you really need to send this to the linux-m68k list. It looks like this
> was originally a copy of the IDE driver for ppc based Macintoshes and
> this particular feature was never finished.
> 
> Just in case you don't know where to find the linux-m68k mailing list,
> it is hosted on vger.kernel.org.
> 
> 	Brad Boyer
> 	flar@allandria.com
