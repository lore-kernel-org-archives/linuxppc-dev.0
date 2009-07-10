Return-Path: <Ian.Campbell@eu.citrix.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0C996B7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 11 Jul 2009 00:11:44 +1000 (EST)
Received: from SMTP02.CITRIX.COM (smtp02.citrix.com [66.165.176.63])
	by ozlabs.org (Postfix) with ESMTP id 7DE3EDDDFA
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Jul 2009 00:11:43 +1000 (EST)
Subject: Re: [PATCH 00/11] swiotlb: Introduce architecture-specific APIs to
	replace __weak functions (v2)
From: Ian Campbell <Ian.Campbell@citrix.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1247205356.15530.18.camel@pasglop>
References: <1243870383-12954-1-git-send-email-ian.campbell@citrix.com>
	<1247205356.15530.18.camel@pasglop>
Content-Type: text/plain
Date: Fri, 10 Jul 2009 15:02:07 +0100
Message-ID: <1247234527.4002.420.camel@zakaz.uk.xensource.com>
MIME-Version: 1.0
Cc: Kumar, Jeremy Fitzhardinge <jeremy@goop.org>,
	Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
	Olaf Kirch <okir@suse.de>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>, x86@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-07-10 at 15:55 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2009-06-01 at 16:32 +0100, Ian Campbell wrote:
> > This series:[...]

> Looks like I was only CCed on part of them... it's not very handy for me
> as I end up having some of the patches in one folder and some
> elsewhere :-)

Sorry about that -- I was concerned about spamming the world and his dog
with patches which didn't directly interest them. For any future series
of this type I'll CC everyone on everything.

Ian.
