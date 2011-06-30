Return-Path: <dedekind1@gmail.com>
Received: from mail-iy0-f170.google.com (mail-iy0-f170.google.com
	[209.85.210.170]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F3715B6F00
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jun 2011 21:50:22 +1000 (EST)
Received: by iym1 with SMTP id 1so2248177iym.15
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jun 2011 04:50:16 -0700 (PDT)
Subject: Re: [PATCH 2/2] mtd/nand : workaround for Freescale FCM to support
	large-page Nand chip
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Date: Thu, 30 Jun 2011 14:51:08 +0300
In-Reply-To: <20110629114329.154aaef2@schlenkerla.am.freescale.net>
References: <1309225852-1664-1-git-send-email-b35362@freescale.com>
	<1309225852-1664-2-git-send-email-b35362@freescale.com>
	<1309328529.23597.106.camel@sauron>
	<20110629114329.154aaef2@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1309434673.23597.176.camel@sauron>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, b35362@freescale.com, dwmw2@infradead.org,
	linux-mtd@lists.infradead.org
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-06-29 at 11:43 -0500, Scott Wood wrote:
> On Wed, 29 Jun 2011 09:22:04 +0300
> Artem Bityutskiy <dedekind1@gmail.com> wrote:
> 
> > On Tue, 2011-06-28 at 09:50 +0800, b35362@freescale.com wrote:
> > > +	/* Hack for supporting the flash chip whose writesize is
> > > +	 * larger than 2K bytes.
> > > +	 */
> > 
> > Please, use proper kernel multi-line comments. Please, make sure
> > checkpatch.pl does not generate 13 errors with this patch.
> 
> Most of the checkpatch complaints are about existing style in the file --
> particularly, the use of tabs only for indentation, with spaces used for
> alignment beyond the indentation point.

OK, fair enough, but the multi-line comment is a valid complain,
although minor. And you guys could just fix the style issues as well in
a separate patch-set.

-- 
Best Regards,
Artem Bityutskiy
