Date: Mon, 7 Jun 1999 17:19:42 -0700 (MST)
From: Matt Porter <mporter@phx.mcd.mot.com>
To: Gabriel Paubert <paubert@iram.es>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.9 patch for Motorola support.
In-Reply-To: <Pine.HPP.3.96.990607140855.27048C-100000@gra-ux1.iram.es>
Message-ID: <Pine.LNX.3.96.990607150045.28505D-100000@fwrsl-11.phx.mcd.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 7 Jun 1999, Gabriel Paubert wrote:
> On Wed, 26 May 1999, Matt Porter wrote:
> 
> > 
> > Below is a cumulative patch versus official 2.2.9 to support Motorola
> > boards.  Fixes OpenPIC irq handling, kbd controllerless board support, and
> > initrd relocation.
> 
> Fine, butif you set CONFIG_VT to off the kernel won't link.  
> BTW why don't you set CONFIG_VT to off for machines without KB
> controller ?

To fit in with the Debian dist I needed a PReP kernel image that can
handle ser_con, vga_con, and fb_con so something works on all systems out 
of the box. I've since changed my VT-based hack to a more generic method
using the keyboard presence flag that is set in prep_pci.c.  This solves
the build problem with the old method...
 
--
Matt Porter				Motorola Computer Group
mporter@mcg.mot.com			Real Time Software Support


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
