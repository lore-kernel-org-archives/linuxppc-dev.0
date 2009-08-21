Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DD035B7B7F
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 22 Aug 2009 00:54:48 +1000 (EST)
Received: from mail-yw0-f171.google.com (mail-yw0-f171.google.com
	[209.85.211.171]) by ozlabs.org (Postfix) with ESMTP id 44349DDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Aug 2009 00:54:47 +1000 (EST)
Received: by ywh1 with SMTP id 1so1060706ywh.9
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 07:54:45 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20090821160116.b4a7b713.sfr@canb.auug.org.au>
References: <20090821052714.2289.41279.stgit@localhost.localdomain>
	<20090821053014.2289.59798.stgit@localhost.localdomain>
	<20090821160116.b4a7b713.sfr@canb.auug.org.au>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 21 Aug 2009 08:54:25 -0600
Message-ID: <fa686aa40908210754s5e54af99sdbd11eb6ec48b5f9@mail.gmail.com>
Subject: Re: [PATCH 2/3] powerpc/pci: move pci_64.c device tree scanning code
	into pci-common.c
To: Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "David S. Miller" <davem@davemloft.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 21, 2009 at 12:01 AM, Stephen Rothwell<sfr@canb.auug.org.au> wr=
ote:
>
> And similarly with sparc's pci_parse_of_addrs() and pci_parse_of_flags
> () ? =A0Maybe create drivers/of/pci.c (or drivers/pci/of.c)? =A0Or maybe =
they
> are still too different?
>
> There is probably scope for more consolidation there.

I agree, but I'll do those things in a separate patch.  I'm making as
few code changes as possible in this patch to ease review.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
