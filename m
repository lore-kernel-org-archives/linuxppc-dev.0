Message-ID: <002401c377cf$bcff2800$6401a8c0@sazabimobile>
From: "Shih-Ying Chou" <sschou@mtu.edu>
To: =?iso-8859-1?Q?Andr=E9_L=E4mmer?= <alaemmer@fh-konstanz.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <000001c377b5$d341b2f0$0f21258d@fhkonstanz.de>
Subject: Re: Compiling Kernel 2.6 for ppc32 
Date: Wed, 10 Sep 2003 15:14:20 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> *** 2.6 kernels no longer buildcorrectly with old versions of binutils.
> *** Please upgrade your binutils to 2.12.1 or newer
>
> Will be there a new release in the next time?
>

You can go to http://kegel.com/crosstool/ to download the scripts that can
help you to get the newer version of gcc, glibc and binutils.  I have used
it to create a cross-compile tool chain and the tool chain can compile the
2.6.0-test5 successfully.   The scripts do support several processor
architecture including ppc and others.

Hope this can help you.

Shih-Ying Chou


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
