Date: Fri, 31 May 2002 12:39:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Matthew Locke <mlocke@mvista.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Dan Malek <dan@embeddededge.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: LMBench and CONFIG_PIN_TLB
Message-ID: <20020531023938.GB16537@zax>
References: <20020529030838.GZ16537@zax> <3CF4E842.3070207@embeddededge.com> <15605.24191.948013.249297@argo.ozlabs.ibm.com> <3CF581BE.8020207@embeddededge.com> <3CF64E9C.60303@mvista.com> <15606.47823.449239.651529@argo.ozlabs.ibm.com> <3CF6AF4C.1070302@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CF6AF4C.1070302@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, May 30, 2002 at 04:01:32PM -0700, Matthew Locke wrote:
>
> Paul Mackerras wrote:
>
> >>btw, there are bugs with it.  Starting several processes with init or
> >>even telnetd will expose the bug.
> >>
> >
> >David and I haven't been able to reproduce this on the Walnut or the
> >EP405.  What sort of machine are you using, what processor, how much
> >RAM, and what distro are you using?
> >
> >Paul.
>
> I run MVL (of course) on a walnut with 32MB of RAM.  What is your
> environment?  btw, MVL uses soft-float in glibc not floating point
> emulation in the kernel.

I've tried it both on a Walnut (PVR 401100c4) with 128MB of RAM, root
filesystem on an IDE disk attached to a Promis PCI IDE controller and
on an EP405PC board (PVR 40110145) with 64MB of RAM with NFS root.  In
both cases userland is Debian/sid running with kernel math emulation.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
