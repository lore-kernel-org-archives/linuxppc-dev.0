Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 94EFB67C7D
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 20:09:25 +1000 (EST)
Subject: Re: [PATCH 7/7] [POWERPC] implement BEGIN/END_FW_FTR_SECTION
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20061004182652.a8600f11.sfr@canb.auug.org.au>
References: <20060926133413.8ca8142e.sfr@canb.auug.org.au>
	<20060926133548.43afd711.sfr@canb.auug.org.au>
	<20060926133651.897ad602.sfr@canb.auug.org.au>
	<20060926133756.071a981f.sfr@canb.auug.org.au>
	<20060926133910.23948614.sfr@canb.auug.org.au>
	<20060926134008.45905bff.sfr@canb.auug.org.au>
	<20060926134222.9e035cc8.sfr@canb.auug.org.au>
	<1159948683.13323.74.camel@localhost.localdomain>
	<20061004182652.a8600f11.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Wed, 04 Oct 2006 20:08:55 +1000
Message-Id: <1159956535.13323.113.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-10-04 at 18:26 +1000, Stephen Rothwell wrote:
> Hi Ben,
> 
> On Wed, 04 Oct 2006 17:58:03 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > I'd rather have a single apply_ftr_fixups() that takes the start/stop of
> > the fixup table and the value to compare against. That could then be
> > called for fw fixups at boot, fw fixups from modules, cpu fixups at
> > boot, cpu fixups from modules, and possibly fixups in the vdso's is a
> > feature I've been thinking of, and which would be easier with just a
> > single function like that.
> 
> I agree entirely, but my PowerPC assembly skills are not up to it :-(

Ok, I'll do that with you later this week

Ben.
