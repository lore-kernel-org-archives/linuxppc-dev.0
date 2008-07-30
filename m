Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910807291709j49cacaa7gcc05f075f0691682@mail.gmail.com>
Date: Tue, 29 Jul 2008 20:09:22 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: verbose kernel debug
In-Reply-To: <20080729234012.GA13708@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910807291547p3ddd6b15nbe4516657e2e014f@mail.gmail.com>
	<488FA22C.5060100@freescale.com>
	<9e4733910807291612l5e0567d6t376c2f96c5169333@mail.gmail.com>
	<20080729234012.GA13708@secretlab.ca>
Cc: Scott Wood <scottwood@freescale.com>, ppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/29/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Tue, Jul 29, 2008 at 07:12:58PM -0400, Jon Smirl wrote:
>  > On 7/29/08, Scott Wood <scottwood@freescale.com> wrote:
>  > > Jon Smirl wrote:
>  > >
>  > > > I'm getting a "Badness at c01cc228 [verbose debug info unavailable]"
>  > > >
>  > > > How do I turn on verbose debug support? Or is it helpful? I see the
>  > > > option for x86 but I don't see how to do it for PowerPC.
>  > > >
>  > >
>  > >  Under "Kernel Hacking", enable "Kernel debugging".  This will expose a
>  > > "Verbose BUG() reporting" option.
>  > >
>  > >  IMHO, this option shouldn't be buried in this manner; it's not just for
>  > > hacking kernels, but also for submitting decent bug reports.
>  >
>  > I looked in there. The option is not appearing for my MPC5200.
>
>
> Hmmm, I can see it right now on a 5200 configured kernel.  It's right
>  before "Compile the kernel with debug info" option.
>
>  It also helps to make sure CONFIG_EMBEDDED is disabled, or if it is
>  enabled that CONFIG_KALLSYMS is enabled.

More needs to be selected, I still can't get it to appear.

I'm digging through Kconfig....


>
>
>  g.
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
