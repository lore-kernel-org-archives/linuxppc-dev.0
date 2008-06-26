Return-Path: <stephen.neuendorffer@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH] powerpc/bootwrapper: Add documentation of boot
	wrappertargets
Date: Thu, 26 Jun 2008 13:16:41 -0700
In-Reply-To: <1214507238.7698.3.camel@weaponx>
References: <20080625202104.30114.47902.stgit@trillian.secretlab.ca>
	<20080626164842.1D3AB1358053@mail15-sin.bigfish.com>
	<1214507238.7698.3.camel@weaponx>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "Josh Boyer" <jwboyer@gmail.com>
Message-ID: <20080626201643.D01221788058@mail223-wa4.bigfish.com>
Cc: John Linn <linnj@xilinx.com>, petermendham@computing.dundee.ac.uk,
	linuxppc-dev@ozlabs.com, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Josh Boyer [mailto:jwboyer@gmail.com]
> Sent: Thursday, June 26, 2008 12:07 PM
> To: Stephen Neuendorffer
> Cc: grant.likely@secretlab.ca; John Linn; linuxppc-dev@ozlabs.com;
paulus@samba.org;
> petermendham@computing.dundee.ac.uk
> Subject: RE: [PATCH] powerpc/bootwrapper: Add documentation of boot
wrappertargets
> =

> On Thu, 2008-06-26 at 09:48 -0700, Stephen Neuendorffer wrote:
> > My unanswered questions:
> >
> > 1) Why are there 4 different types of targets that embed a device
tree?
> > I assume they differ in how they are started loaded, but
(unfortunately)
> > the names are meaningless (With the exception of cuImage, which is
only
> > cryptic.. :)  If I'm adding support for a new board, which should I
use?
> =

> They are all needed to deal with different firmwares.

Where 'firmware' really means 'method of invoking the kernel'

> treeImage is for OpenBIOS based boards (Ebony, Walnut, some boards
> running PIBS can also use this).  This firmware requires a special
> header on the image file.

So it's not an elf? or it is an .elf?  maybe it should be
'openBiosImage'?
 =

> cuImage is for boards running an older U-Boot that does not understand
> device trees.

Forgive my ignorance here, but what specifically does this imply?  As
far as I can tell, generally speaking, some of the board-specific
information is passed into the boot wrapper, which then stuffs it into
the device tree.

> uImage is for device-tree aware U-Boot versions

And this differs from above because it gets a device tree passed in,
which uboot has already stuffed correctly.

> dtbImage is used for boards that can take an ELF zImage, but still
need
> a dtb provided.
> =

> simpleImage, not sure here.

So both of these are elfs...  but how do they differ?  Is it only in how
the right head.s file gets picked up?

Steve


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
