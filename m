Message-ID: <385711B2.4574D1D2@netx4.com>
Date: Tue, 14 Dec 1999 22:57:38 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Brian Kuschak <bkuschak@yahoo.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: glibc 1.99-8xx include files?
References: <19991212014800.9853.qmail@web307.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brian Kuschak wrote:


> It appears that the glibc header files in the
> mbxroot.full.tgz filesystem on the ftp site are for
> glibc version 2.0.

I don't think so.....that image was created long before
the glibc2 version existed.

> ...  I'm using the glibc-1.99 version
> with the 8xx patches.

This should work.....


> My code is including the 2.0 headers, but linking to
> the 1.99 library.  It's not very happy :-)

Are you sure this is happening?  When I boot an 8xx using
the mbxroot.full file system, I can compile programs on it
that run just fine.  Maybe I haven't stumbled across the
features you are trying to use.

I know that cross compiling to use glibc-1.99 on any system
is very error prone.  I certainly haven't yet mastered it,
but I am a little slow sometimes.  I still have an old R4 iMac
for this purpose.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
