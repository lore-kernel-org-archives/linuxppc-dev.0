To: David Woodhouse <dwmw2@infradead.org>
Cc: Pantelis Antoniou <panto@intracom.gr>,
	Meriin Michael-BMM063 <Meriin@motorola.com>,
	"'Ricardo DIz'" <rdiz@alumni.deec.uc.pt>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: U-Boot and kernel 2.6 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 11 Jun 2004 15:34:13 BST."
             <1086964452.15845.1308.camel@hades.cambridge.redhat.com>
Date: Fri, 11 Jun 2004 17:11:16 +0200
Message-Id: <20040611151121.62F07C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <1086964452.15845.1308.camel@hades.cambridge.redhat.com> you wrote:
> On Fri, 2004-06-11 at 17:16 +0300, Pantelis Antoniou wrote:
> > Yeah, having the bi_recs interface actually working
> > would be ideal, but at the present time nothing is
> > working and as AFAIK no-one is working on it.
>
> So we should offer some gentle encouragement. Like refusing to accept
> any further modifications to include/asm-ppc/ppcboot.h.

Then you must also refuse to accept any  further  modifications  that
define  "struct  bd_info"  for  any boards. Or please explain why you
think that one definiton of bd_info which gets used by many boards is
worse then several private definitions of the same structure used  by
one board only in each case?

Let's see:

linuxppc-2.4				linuxppc-2.5
----------------------------------------------------
-> cd arch/ppc/platforms		-> cd arch/ppc/platforms
-> grep bd_info * | wc -l		-> grep bd_info * | wc -l
      6					      8
-> grep ppcboot.h * | wc -l		-> grep ppcboot.h * | wc -l
      9					     12

Before phasing out a working solution, even if it's  a  poor  design,
you should provide a new, better solution.

I promise: I will make sure that U-Boot supports the new interface as
soon as there is any definitive agreement about what  it's  going  to
look like. As mentioned before - I'd be happy to accept what has been
discussed more than two years ago, especially Mark's proposal.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Experience is what causes a person to make new  mistakes  instead  of
old ones.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
