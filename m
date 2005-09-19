Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D3EAC682C0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Sep 2005 03:15:02 +1000 (EST)
Date: Mon, 19 Sep 2005 10:14:59 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Stefan Roese <sr@denx.de>
Message-ID: <20050919171458.GA8367@gate.ebshome.net>
References: <ea43f4f9050825183121655ba2@mail.gmail.com>
	<200509191302.15462.sr@denx.de> <20050919065942.A25356@cox.net>
	<200509191706.24298.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200509191706.24298.sr@denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: cleanup AMCC PPC4xx eval boards to better
	support U-Boot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Sep 19, 2005 at 05:06:23PM +0200, Stefan Roese wrote:
> Hi Matt,
> 
> On Monday 19 September 2005 15:59, Matt Porter wrote:
> > On Mon, Sep 19, 2005 at 01:02:14PM +0200, Stefan Roese wrote:
> > > Just to be sure: The 44x boot-wrapper approach you mention is
> > > "boot/simple/pibs.c"?
> >
> > Yes, there's both boot/simple/pibs.c and boot/simple/openbios.c that
> > were created so we could have the default firmware and u-boot use the
> > same kernel build.
> 
> Yes, that's what I thought. But Eugene mentioned, that he boots vmlinux 
> without any boot-wrapper on the OpenBIOS targets (except Ebony probably).

Bad phrasing on my part. What I meant was "U-Boot is different from 
OpenBIOS targets already, as with U-Boot we don't use any boot-wrapper 
like with OpenBIOS".

Sorry for confusion :).

-- 
Eugene
