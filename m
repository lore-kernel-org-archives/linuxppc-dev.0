Date: Tue, 27 Nov 2001 05:00:41 -0700
From: Matt Porter <mporter@mvista.com>
To: Dan Malek <dan@embeddededge.com>
Cc: paulus@samba.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: include/asm-ppc/platforms/
Message-ID: <20011127050040.A15728@cx258813-a.chnd1.az.home.com>
References: <15363.31192.101536.919771@gargle.gargle.HOWL> <3C2B376F.9070508@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3C2B376F.9070508@embeddededge.com>; from dan@embeddededge.com on Thu, Dec 27, 2001 at 09:59:59AM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Dec 27, 2001 at 09:59:59AM -0500, Dan Malek wrote:
>
> Paul Mackerras wrote:
>
>
> > Does anyone have any comments or objections?
>
> That's a pretty good idea, and I have another one.  Name the
> directory include/asm-ppc/ppc-platforms or something, then
> have a symbolic link
> 	include/asm/platform -> include/asm-ppc/ppc-platforms/<board-file>
>
> That way we can just #include <platform.h> instead of having lots
> of ifdefs in upper level files to determine which one is needed.  If
> we are moving files around, let's have some effect on actually making
> it easier to use them, too.

Yes, this is similar to what has worked well in the arm tree.

--
Matt Porter
MontaVista Software, INc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
