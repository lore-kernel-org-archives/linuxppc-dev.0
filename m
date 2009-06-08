Return-Path: <arnd@arndb.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 124DCB70B6
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  8 Jun 2009 18:57:21 +1000 (EST)
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 43A45DDD01
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Jun 2009 18:57:18 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org,
 michael@ellerman.id.au
Subject: Re: mailing list moving
Date: Mon, 8 Jun 2009 10:56:58 +0200
References: <20090531150950.596d2681.sfr@canb.auug.org.au>
	<20090605190831.c5d59095.sfr@canb.auug.org.au>
	<1244277467.4277.12.camel@concordia>
In-Reply-To: <1244277467.4277.12.camel@concordia>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200906081056.59050.arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	linuxppc-dev-owner@lists.ozlabs.org, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Saturday 06 June 2009, Michael Ellerman wrote:
> On Fri, 2009-06-05 at 19:08 +1000, Stephen Rothwell wrote:
> > I do, however, have the old archives, so maybe we can do something ...
> 
> We could use the old archive to work out the mapping between old and new
> and write a billion rewrite rules, but it'd probably crash the rewrite
> code - and if not slow the server to a crawl.
> 
> So into the too hard basket I think :)

How about just doing a 'wget -r' on the old archive and storing it
in some random directory on lists.ozlabs.org as static files?
Then you only need a single rewrite rule.

	Arnd <><
