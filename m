Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 06FA5DDE16
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 16:48:54 +1000 (EST)
Subject: Re: [PATCH 1/2] elf loader support for auxvec base platform string
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland McGrath <roland@redhat.com>
In-Reply-To: <20080707063522.5FE55154246@magilla.localdomain>
References: <20080703234140.GC9594@localdomain>
	<20080704021929.5E9EF1541F5@magilla.localdomain>
	<1215409693.8970.79.camel@pasglop>
	<20080707061811.19989154246@magilla.localdomain>
	<1215411800.8970.91.camel@pasglop>
	<20080707063522.5FE55154246@magilla.localdomain>
Content-Type: text/plain
Date: Mon, 07 Jul 2008 16:48:47 +1000
Message-Id: <1215413327.8970.108.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2008-07-06 at 23:35 -0700, Roland McGrath wrote:
> > I'm not sure... if ld.conf.d isn't parse of the kernel source tree then
> > it -will- end in tears...
> 
> Of course, you should include the file you want people to install
> as part of the kernel source or build.  You can copy it into
> place in make install or something if you like (convention is to
> call it something.conf in /etc/ld.so.conf.d); then run ldconfig.
> The x86-xen case has not bothered to include its one-line file as
> such, just the comment in arch/x86/vdso/vdso32/note.S telling you
> what it is.

Nathan, can you discuss that with Steve Munroe and see if he's ok
with such an approach ?

Cheers,
Ben.
