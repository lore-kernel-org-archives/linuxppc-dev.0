Date: Tue, 26 Oct 1999 13:21:24 -0700 (PDT)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Mike Panetta <mpanetta@realminfo.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems compiling ppc kernels.
In-Reply-To: <19991026134728.A25022@alice.realminfo.com>
Message-ID: <Pine.LNX.4.10.9910261317440.374-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



	There are a few still outstanding config issues in 2.3.23, take a
look at my patch for 2.3.22 at 
	ftp://devel.linuxppc.org/users/ajoshi/2.3.22-ppc.patch

	it should apply to 2.3.23, even if it doesn't it should provide
you with enuff info to get your .23 to build.

iirc, swim3 needs a few #ifdef CONFIG_PMAC_PBOOK around all its media_bay
calls, as with ide-pmac.  both of which are in the patch.

btw, its a good idea *not* to config for pmac/chrp/prep for pmacs, but
only for pmac.


ani

On Tue, 26 Oct 1999, Mike Panetta wrote:

> 
> I have been having some real weird problems with compiling 
> kernels for my iMAC.  I have tried kernel versions 2.2.12, 2.3.23, 2.3.21
> And have goten pretty much the same results.  In all these compile attemts
> I have had to make drivers/usb/mkmap (2.2.x), or drivers/usb/mkmap.adb (2.3.x)
> executable because the Makefile complained that it did not have permissions to
> run the script.  After that was fixed I had various linking problems at the
> very end of the compile when it was making vmlinux.  Usually pertaining to 
> mac_floppy or something.  Disabling this in the .config did not help.  It just


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
