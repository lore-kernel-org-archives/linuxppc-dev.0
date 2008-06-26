Return-Path: <jwboyer@gmail.com>
Subject: RE: [PATCH] powerpc/bootwrapper: Add documentation of boot wrapper
	targets
From: Josh Boyer <jwboyer@gmail.com>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
In-Reply-To: <20080626164842.1D3AB1358053@mail15-sin.bigfish.com>
References: <20080625202104.30114.47902.stgit@trillian.secretlab.ca>
	<20080626164842.1D3AB1358053@mail15-sin.bigfish.com>
Content-Type: text/plain
Date: Thu, 26 Jun 2008 15:07:18 -0400
Message-Id: <1214507238.7698.3.camel@weaponx>
Mime-Version: 1.0
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

On Thu, 2008-06-26 at 09:48 -0700, Stephen Neuendorffer wrote:
> My unanswered questions:
> 
> 1) Why are there 4 different types of targets that embed a device tree?
> I assume they differ in how they are started loaded, but (unfortunately)
> the names are meaningless (With the exception of cuImage, which is only
> cryptic.. :)  If I'm adding support for a new board, which should I use?

They are all needed to deal with different firmwares.

treeImage is for OpenBIOS based boards (Ebony, Walnut, some boards
running PIBS can also use this).  This firmware requires a special
header on the image file.

cuImage is for boards running an older U-Boot that does not understand
device trees.

uImage is for device-tree aware U-Boot versions

dtbImage is used for boards that can take an ELF zImage, but still need
a dtb provided.

simpleImage, not sure here.

josh
