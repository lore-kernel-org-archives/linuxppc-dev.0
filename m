Date: Thu, 24 Feb 2000 19:48:02 +0200 (EET)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Kevin Hendricks <khendricks@ivey.uwo.ca>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work on ppc
 with r128
In-Reply-To: <00022410155400.20404@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0002241917120.2343-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 24 Feb 2000, Kevin Hendricks wrote:

> Hi,
>
> Yesterday the last Xfree4.0 snapshot was released (xf3.9.18).  Because of all
> of the hard work of Kostas integrating powerpc changes into the official xf 4.0
> tree, the xf3918 snapshot almost builds out of the box and provides wonderful
> Rage128 acceleration at 16bpp and 32bpp.
>
> The only changes needed were to xfree86.cf to add the r128 module to those being
> built on powerpc and a patch to lnxResource.c provided by Kostas.
>
  Although xfree86 will build (and mostly work) with the provided patch for
lnxResource.c, the patch *is not* correct for ppc, we need to get the info
needed for it at runtime (ioBase etc etc..). Having iobase setup correctly
will allow us to use quite a few unsupported for now drivers (S3 etc..)

> Thanks,
>
> Kevin
>

 Kostas Gewrgiou


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
