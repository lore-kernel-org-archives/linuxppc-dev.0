Message-ID: <3B38EE7B.2D4268A6@xyterra.com>
Date: Tue, 26 Jun 2001 13:20:11 -0700
From: "Tim M. Sanders" <tsanders@xyterra.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: linking RAM disk with kernel image for ROM
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Where can I find a document that describes how to include a RAM disk
image (initrd ?) in the linux kernel image?

I want to put the entire image in flash, boot from flash and use a RAM
disk for the root file system.

I know how to create a RAM disk image.  I just don't know where to put
it in the linux tree so it is linked into the final linux image.  Also I
am assuming there needs to be some commands on the linux boot prompt.
What is required to use a RAM disk image as the root file system.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
