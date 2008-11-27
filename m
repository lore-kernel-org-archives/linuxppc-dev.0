Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D442CDDED4
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Nov 2008 02:57:19 +1100 (EST)
From: Yuri Tikhonov <yur@emcraft.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH][v2] xsysace: use resource_size_t instead of unsigned long
Date: Thu, 27 Nov 2008 18:48:26 +0300
References: <200811271521.27642.yur@emcraft.com>
	<fa686aa40811270611j58ceb6e5lffc37fc3f83d00e7@mail.gmail.com>
In-Reply-To: <fa686aa40811270611j58ceb6e5lffc37fc3f83d00e7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200811271848.26520.yur@emcraft.com>
Cc: Detlev Zundel <dzu@denx.de>, Ilya Yanok <yanok@emcraft.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


 Hello Grant,

On Thursday 27 November 2008 17:11, Grant Likely wrote:
> On Thu, Nov 27, 2008 at 5:21 AM, Yuri Tikhonov <yur@emcraft.com> wrote:
> > Use resource_size_t for physical address of SystemACE
> > chip. This fixes the driver brokeness for 32 bit systems
> > with 64 bit resources (e.g. PPC440SPe).
> 
> Hey Yuri,
> 
> I actually already picked up the last version of your patch after
> fixing it up myself.  It's currently sitting in Paul's powerpc tree
> and it will be merged into mainline when Linus gets back from
> vacation.

 Oops. Indeed. Thanks.

> 
> Can you please spin a new version with just the addition of the
> compatible value and base it on Paul's tree.

 Sure. I've generated the patch against the origin/merge branch of Paul's 
tree, and posting it as separate "[PATCH] xsysace: add compatible string
".

 Regards, Yuri
