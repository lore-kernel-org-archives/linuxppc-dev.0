Message-ID: <3D140299.2010005@broadon.com>
Date: Fri, 21 Jun 2002 21:52:41 -0700
From: David Blythe <blythe@broadon.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Can I run linux without a file system?
References: <5.1.0.14.2.20020621155315.05f3e830@falcon.si.com> <20020621194234.37274.qmail@web21103.mail.yahoo.com> <200206211835.g5LIZDL01282@hofr.at> <5.1.0.14.2.20020621164532.05f55b50@falcon.si.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


use uclibc and busybox.  it is pretty straightforward to get a root file
system smaller than 1M with lots of useful stuff, either with or without
shared libraries (shared uclibc is < 300K including ld.so on my ppc
system, busybox is 200K including ash,mv,cp,ls,...).  The downside is
you have to build all of the stuff yourself, but if you want to optimize
for space, sooner or later you'll end up building it all yourself.

	david


Jerry Van Baren wrote:
>
> OK, you and John Kerl caught me fear-mongering :-).  Thank you for the link
> and shameless plug, it looks very, very useful.  4.8MB is very respectable
> but not what most people think about when they say "minimal file
> system".  Tim wants less than 1MByte, care to take up THAT challenge
> :-)?  That would require shrinking the libraries to just the necessary
> functions, which is a big jump in difficulty.
>
> gvb
>
>
> At 02:31 PM 6/21/2002 -0600, Dr. Craig Hollabaugh wrote:
>
...


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
