To: David de =?iso-8859-1?Q?Andr=E9s=20Mart=EDnez?= <ddandres@disca.upv.es>
Cc: linuxppc-embedded@lists.linuxppc.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: libc.so.6 error but not in Montavista 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 14 Apr 2001 09:23:36 +0200."
             <3AD7FAF8.44670189@disca.upv.es>
Date: Sun, 23 Sep 2001 20:00:22 +0200
Message-Id: <20010923180027.B704A1009E@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3AD7FAF8.44670189@disca.upv.es> you wrote:
>
> I have built the CDK withouth any problems and so the ramdisk.
> But when I try to boot the system, I obtain the following error:
> ....
> init: error in loading shared libraries: libc.so.6: cannot open shared
> object fi
> le: No such file or directory
...
> If your shared libraries are (as usual) in the "/lib" directory, add the
> following option to the GCC command line when linking your binary:
> -Wl,-R/lib
> --------
> In fact, I don't know where to add this option.

There is a patch for our old version of the cross tools; see
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/patches/specs.tar.bz2

This fixes the compiler "specs" files to automatically add this option.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Harrison's Postulate:
	For every action, there is an equal and opposite criticism.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
