Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 464F9DDE47
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 10:23:29 +1000 (EST)
Date: Mon, 1 Oct 2007 19:27:24 -0500
From: Olof Johansson <olof@lixom.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] powerpc: Implement logging of unhandled signals
Message-ID: <20071002002724.GA17867@lixom.net>
References: <20071001203242.GA14091@lixom.net>
	<20071002094130.98cdcff6.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071002094130.98cdcff6.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 02, 2007 at 09:41:30AM +1000, Stephen Rothwell wrote:
> Hi Olof,
> 
> On Mon, 1 Oct 2007 15:32:42 -0500 Olof Johansson <olof@lixom.net> wrote:
> >
> > +	char fmt32[] = KERN_INFO "%s[%d]: unhandled signal %d " \
> > +			"at %08lx nip %08lx lr %08lx code %x\n";
> > +	char fmt64[] = KERN_INFO "%s[%d]: unhandled signal %d " \
> > +			"at %016lx nip %016lx lr %016lx code %x\n";
> 
> const char ... ?
> 
> > +static char fmt32[] = KERN_INFO \
> > +	"%s[%d]: bad frame in %s: %08lx nip %08lx lr %08lx\n";
> > +static char fmt64[] = KERN_INFO \
> > +	"%s[%d]: bad frame in %s: %016lx nip %016lx lr %016lx\n";
> 
> again?

Yeah, sure.


Thanks,

-Olof
