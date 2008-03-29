Return-Path: <bzolnier@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id 571CEDDE26
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Mar 2008 02:55:49 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so134973uge.0
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 08:55:48 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 15/18] ide: remove broken/dangerous HDIO_[UNREGISTER,
	SCAN]_HWIF ioctls
Date: Sat, 29 Mar 2008 17:10:54 +0100
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
	<47EBDBAA.2020308@ru.mvista.com> <47ED439C.9030400@rtr.ca>
In-Reply-To: <47ED439C.9030400@rtr.ca>
MIME-Version: 1.0
Message-Id: <200803291710.54843.bzolnier@gmail.com>
Content-Type: text/plain;
  charset="utf-8"
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 28 March 2008, Mark Lord wrote:
> Sergei Shtylyov wrote:
> > Bartlomiej Zolnierkiewicz wrote:
> > 
> >> hdparm explicitely marks HDIO_[UNREGISTER,SCAN]_HWIF ioctls as DANGEROUS
> >> and given the number of bugs we can assume that there are no real users:
> ..
> 
> There is the odd user of these, actually.
> 
> But the most recent to email me (a few weeks ago),
> reported that the SCAN function was no longer working on his kernel.
> 
> I'll remove the -R and -U flags completely from hdparm-8.7.

This will be quite helpful, thanks!

Bart
