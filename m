Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Driver Hell: was Re: GeForce on PPC == _no work_
Date: Sun, 28 Oct 2001 11:13:44 -0500
Cc: Ani Joshi <ajoshi@shell.unixbox.com>,
	<linuxppc-dev@lists.linuxppc.org>
References: <20011028125007.MHAN10438.tomts12-srv.bellnexxia.net@there> <20011028145435.7084@smtp.wanadoo.fr>
In-Reply-To: <20011028145435.7084@smtp.wanadoo.fr>
MIME-Version: 1.0
Message-Id: <20011028151111.JZNC28233.tomts15-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

How does Darwin even boot on some machines without this support.  Do they
instead install some binary only driver set?

Also why all the secrecy about drivers in general.

Right now I seem to be in driver hell:

- firewire does not work

- radeon fp does not work

- new driver for adaptec scsi drivers does not work (old ones do)

- the new tulip ethernet driver does not really support Lite-On PNIC2
  negotiation (seems to have been hardwired to 100mb?).    Again, at
  least the old becker driver did work at 10baseT-HD.

Being an old EE who used to write his own drivers, all we really need is
the damn interface description and some sample code but I could not find
anything publicly on either the Radeon, the Lite-ON PNIC2 (very similar to
a D21143).

Where does one get the equivalent of the old "Data-Books" for these little
gems?  I can remember each little device (DMA chips, processor, memory
controller, etc each came with enough info and examples to get them
working (after playing around long enough).  Why today do they make it so
hard for people to find information on them? Or am I just looking in the
wrong place?

What is the technical or business rationale for making your "product" hard
to use?  Is there some kickback from designer to chip maker that has come
into existance that I am missing here?  Since they basically give away
binary drivers (and not selling them) keeping info locked up just makes no
business sense to me?

Anyone with insights here they would like to share?

Thanks,

Kevin


On October 28, 2001 09:54, Benjamin Herrenschmidt wrote:
> >Has anyone looked in the latest Darwin release?  Is there code there
> > that supports flat panels on both Radeon and Nvidia?  If so, where
> > would one look for it?
>
> The video drivers are among the things Apple didn't open source as part
> of Darwin :(
>
> This includes all drivers not entirely owned by Apple (ATI, nVidia,
> Adaptec, Airport, ...) and some Apple drivers they didnt want to open
> source for various (bad) reasons (PMU, ieee1394 controllers).
>
> Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
