Message-ID: <3C05653E.26DA9C14@vnet.ibm.com>
Date: Wed, 28 Nov 2001 22:29:18 +0000
From: Tom Gall <tom_gall@vnet.ibm.com>
Reply-To: tom_gall@vnet.ibm.com
MIME-Version: 1.0
To: Troy Benjegerdes <hozer@drgw.net>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_ALL_PPC
References: <15365.24592.409195.392505@gargle.gargle.HOWL> <20011128162046.L23942@altus.drgw.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Troy Benjegerdes wrote:
>
> On Thu, Nov 29, 2001 at 09:07:12AM +1100, Paul Mackerras wrote:
> >
> > I want to rename CONFIG_ALL_PPC to CONFIG_PREP_PMAC_CHRP in the
> > linuxppc_2_4_devel tree (or if anyone can suggest a better name I'll
> > use that).
> >
> > Does anyone object to this?
>
> I thought were were goign to call it 'CONFIG_WORKSTATION_PPC' or
> 'CONFIG_DESKTOP'
>
> I'd be happy with CONFIG_DESKTOP, or CONFIG_PPC_MULTIARCH.

Hmmm But doesn't that suggest there is CONFIG_PPC_SERVER? Ick!

Not to ask a stupid question, but what is this CONFIG_ALL_PPC replacement trying
to accomplish?

CONFIG_PPC_PREP seems to imply the PREP standard for all it's warts

CONFIG_PPC_CHRP same thing... tho to me a PMAC and a CHRP box are well, sorta
the same thing

I hate to advocate this but if CONFIG_ALL_PPC isn't really being "truthful" as
far as what it is, then perhaps testing for something like CONFIG_PPC_PREP,
CONFIG_PPC_CHRP etc maybe isn't a bad idea. Code bloat true and certainly a
little harder on the eyes, but it is certainly alot more clear as far as the
expectations the affected portion of code might have.

Regards,

Tom

--
Tom Gall - [embedded] [PPC64 | PPC32] Code Monkey
Peace, Love &                  "Where's the ka-boom? There was
Linux Technology Center         supposed to be an earth
http://www.ibm.com/linux/ltc/   shattering ka-boom!"
(w) tom_gall@vnet.ibm.com       -- Marvin Martian
(w) 507-253-4558
(h) tgall@rochcivictheatre.org

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
