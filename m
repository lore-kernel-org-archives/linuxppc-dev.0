Return-Path: <elendil@planet.nl>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7AC08B7242
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 21 Jun 2009 09:26:12 +1000 (EST)
Received: from CPSMTPM-EML109.kpnxchange.com (Cpsmtpm-eml109.kpnxchange.com
	[195.121.3.13]) by ozlabs.org (Postfix) with ESMTP id BC0EEDDD1C
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Jun 2009 09:26:11 +1000 (EST)
From: Frans Pop <elendil@planet.nl>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: Badness on the Warp
Date: Sun, 21 Jun 2009 01:26:08 +0200
References: <20090620154824.72b5cd50@lappy.seanm.ca>
	<200906202256.46073.elendil@planet.nl>
	<20090620191034.48fa085a@lappy.seanm.ca>
In-Reply-To: <20090620191034.48fa085a@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200906210126.09049.elendil@planet.nl>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sunday 21 June 2009, Sean MacLennan wrote:
> On Sat, 20 Jun 2009 22:56:45 +0200 Frans Pop <elendil@planet.nl> wrote:
> > The fact that your bisect ended at a merge essentially means that it
> > is invalid. As a merge does not introduce any actual change (unless
> > it includes changes to resolve conflicts), it normally cannot be the
> > cause of a regression.
>
> Makes sense I messed up somewhere. This is the commit that causes
> problems:
>
> Merge branch 'topic/slab/earlyboot' of
> git://git./linux/kernel/git/penberg/slab-2.6
>
> * 'topic/slab/earlyboot' of
> git://git.kernel.org/pub/scm/linux/kernel/git/penberg/slab-2.6:

Hmmm. That's b640f042faa2, which is another merge...
So you're still not there.
