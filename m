Message-ID: <19991026134728.A25022@alice.realminfo.com>
Date: Tue, 26 Oct 1999 13:47:28 -0400
From: Mike Panetta <mpanetta@realminfo.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Problems compiling ppc kernels.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have been having some real weird problems with compiling 
kernels for my iMAC.  I have tried kernel versions 2.2.12, 2.3.23, 2.3.21
And have goten pretty much the same results.  In all these compile attemts
I have had to make drivers/usb/mkmap (2.2.x), or drivers/usb/mkmap.adb (2.3.x)
executable because the Makefile complained that it did not have permissions to
run the script.  After that was fixed I had various linking problems at the
very end of the compile when it was making vmlinux.  Usually pertaining to 
mac_floppy or something.  Disabling this in the .config did not help.  It just
went on complaining about other symbols not being found.  Could someone please
point me at some patches or directions on what I am doing wrong?  I have never
had a problem compiling kernels on my i386, except for some of the 2.3.x series.
What am I doing wrong? (it must be me since obviously someone compile a kernel!)

Thanks,
Mike Panetta


-- 

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
