Message-ID: <3B5F6857.19E14CE2@mvista.com>
Date: Wed, 25 Jul 2001 17:46:15 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Jeff Studer <jstuder@aquilagroup.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCI bridge support with MontaVista
References: <Pine.LNX.4.10.10107251625340.31481-100000@jeffs.aquilagroup.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jeff Studer wrote:

> Hello all,
>
> We are in the early stages of a new embedded MPC860T project and we are
> looking at using the MontaVista distribution of Linux for the OS.  We need
> PCI support but are flexible on what PCI bridge we will use.
>
> What we need to know is what PCI bridges are supported by with this
> distribution.  I found some PPC PCI bridge support patches mentioned
> online, so I am assuming there may be some PCI bridges that could be
> supported by applying a patch, if the support does not yet exist with
> MontaVista's distribution.  Are there any cases like this?
>
> I did not see information regarding PCI bridge support on MontaVista's
> site, so I am asking here.  We really need to know what is supported so we
> can make a choice on what to use.  Any further information would be
> helpful, regarding ease of use and cost, or any other personal opinions. I
> have worked with the QSpanII with another OS, but we had to write our own
> drivers for that.

Just off the top of my head there are several bridges that are supported, the
Motorola SPS MPC105, MPC106, MPC107 (and MPC824x), the Motorola MCG Raven,
Hawk, Harrier, IBM CPC700 and CPC710, several proprietary bridges, and others
that are in the works.

Since the code already exists for these bridges, working with them
[softwarewise] isn't that much of an issue.  Probably the most important thing
for you would be price & performance.  Unfortunately, I have no idea about the
price and I've never personally gotten around to doing a true apples-to-apples
comparison of the various host bridges & their options.  :(

I'll bet Dan Malek and Matt Porter can provide more insight.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
