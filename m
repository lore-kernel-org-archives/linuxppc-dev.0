Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 391D7DDE38
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 09:51:54 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch 00/13] CPU selection Kconfig cleanup, take 3
Date: Fri, 15 Jun 2007 01:51:39 +0200
References: <20070612163016.253915076@arndb.de>
	<18032.40447.579128.989284@cargo.ozlabs.ibm.com>
	<B4E893D5-A61E-4A91-B31C-AF9B7C0B116D@kernel.crashing.org>
In-Reply-To: <B4E893D5-A61E-4A91-B31C-AF9B7C0B116D@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706150151.40056.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 14 June 2007, Kumar Gala wrote:
> I'm a little hesitant to move the embedded ppc's over to =A0
> multiplatform quite yet. =A0One feature I wanted was in Kconfig a way =A0
> to enforce the selection of at least one choice, as well as being =A0
> able to optimize things since we only had one choice selected.

What would such a potential optimization be like? Are you thinking
of turning the 'platform_is(foo)' check into a compile-time choice,
or are there more places where you can imagine an optimization?
I'd like to understand better what you want to achieve there,
maybe I can find a way to do that in the same series.

=46or the 'at least one option selected' argument, I'm not sure how
important that is, IMHO it falls into the same category as any
other essential option that you can disable.

	Arnd <><
