Return-Path: <satyakiran@gmail.com>
Message-ID: <acbcf3840708171628k242e96ffl2b65011bf6d39512@mail.gmail.com>
Date: Fri, 17 Aug 2007 18:28:50 -0500
From: Satya <satyakiran@gmail.com>
To: "Johan Borkhuis" <j.borkhuis@dutchspace.nl>
Subject: Re: Patches for ppc?
In-Reply-To: <46C5B40F.5040209@dutchspace.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <46C5519E.6010300@dutchspace.nl>
	<1187353616.2778.358.camel@shinybook.infradead.org>
	<46C5B288.2010308@dutchspace.nl>
	<1187361603.2778.382.camel@shinybook.infradead.org>
	<46C5B40F.5040209@dutchspace.nl>
Cc: Linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

hi,
what's the issue with arch/ppc again? why is it being phased out? I am
working with the IBM Blue Gene/L which is based on ppc440. I need to
get a patch in too! :)

I noticed that head_44x.S has been copied to arch/powerpc/kernel in
the current head tree, but is it functional yet? has everything been
moved to arch/powerpc ? how about the include files ?

thanks!
satya.

On 8/17/07, Johan Borkhuis <j.borkhuis@dutchspace.nl> wrote:
> David Woodhouse wrote:
> > On Fri, 2007-08-17 at 16:36 +0200, Johan Borkhuis wrote:
> >
> >> Well, this is one of the minor issues I have with the ppc architecture,
> >> but I am quite happy with it. Even for this I could make a workaround,
> >> but I guess this is something that other might stumble upon.
> >>
> >> I would like to move to powerpc, but for the moment there is no official
> >> support for powerpc, for ppc there is, but I don't have the time to move
> >> this to powerpc. So I am afraid I don't have much choice.
> >>
> >
> > It's times like this you suddenly realise you should have paid the extra
> > cash for a licence which allows you access to the source code?
> >
> >
> That is not the problem: we have access to all the sources, but I am
> waiting for the official support for the powerpc architecure. I am using
> an MVME3100 board from Motorola and I know that they are working on it,
> but it is not released (yet).
>
> Kind regards,
>     Johan Borkhuis
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
