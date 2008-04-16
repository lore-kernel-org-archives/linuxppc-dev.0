Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id D3EC8DE16B
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 07:40:47 +1000 (EST)
From: "Joakim Tjernlund" <Joakim.Tjernlund@transmode.se>
To: "'Timur Tabi'" <timur@freescale.com>
References: <48066857.4030109@freescale.com>
	<062501c8a006$27b17b90$771472b0$@Tjernlund@transmode.se>
	<48066B54.30309@freescale.com>
	<062801c8a006$a7715710$f6540530$@Tjernlund@transmode.se>
	<48066C94.5040707@freescale.com>
In-Reply-To: <48066C94.5040707@freescale.com>
Subject: RE: lseek() on entries in /proc/device-tree returns EINVAL
Date: Wed, 16 Apr 2008 23:40:32 +0200
Message-ID: <064101c8a00a$7fc6a0e0$7f53e2a0$@Tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Timur Tabi [mailto:timur@freescale.com]
> Sent: den 16 april 2008 23:16
> To: Joakim Tjernlund
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: lseek() on entries in /proc/device-tree returns EINVAL
> 
> Joakim Tjernlund wrote:
> 
> > Good, bb should probably do the same. I just hope Al will allow a grace period and restore
> > the old behavior so bb can catch up.
> 
> I don't see any reason why lseek() should not always work.  Besides, a "grace
> period" would mean that on some future kernel, older busybox will not work.

Sure, but better a grace period than none at all. Currently no bb
works but with a grace period you can at least tell users to upgrade bb
when the grace period is over.

 Jocke
