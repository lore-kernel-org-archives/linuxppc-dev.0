Message-ID: <388F471F.D33F9B7C@mandrakesoft.com>
Date: Wed, 26 Jan 2000 14:12:31 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
MIME-Version: 1.0
To: ramp@oddjob.uchicago.edu
CC: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: trying cutting edge kernel ..
References: <Pine.LNX.4.10.10001261247070.7391-100000@xpol.uchicago.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


ramp@oddjob.uchicago.edu wrote:
> After having my USB printer work I wanted to see if my USB Zip250
> would work. I looked at the linux-usb mailing list archives and
> found that some people were working on it and that some devel
> kernels 2.3.41-? could be made to work. So I went to ftp.kernel.org
> and found the following files -
>
> v2.3/linux-2.3.40.tar.bz2
> testing/pre-patch-2.3.41-X.bz2 where X=[1,2,3]
>
> My question is: Do I need to patch all 3 in order or should I just
> patch with the last file - in this case 3.

You just need the greatest 'pre' number, currently 2.3.41-pre3.


> Also, does this include all of the latest 2.3.39 linux-pmac-devel
> from linuxcare.com.au?

I only boot vanilla kernels on my PowerMac 7200.  2.2.15-pre4 works, and
with a little bit of tweaking, 2.3.41-preXX works too.  It's too much of
a PITA to work with loads of patches outside the main kernel source
tree.

I've send a couple small patches off to Cort.  Let me know if you can't
build on 2.3.41-preXX and I'll send the fixes to you and the lists.

	Jeff





--
Jeff Garzik         | Andre the Giant has a posse.
Building 1024       |
MandrakeSoft, Inc.  |

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
