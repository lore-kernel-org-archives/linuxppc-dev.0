Message-ID: <3A9C4179.1AAB9DB4@mvista.com>
Date: Tue, 27 Feb 2001 16:08:25 -0800
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Christian Schroeder <christian.schroeder@imms.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: gdbserver for mpc8xx targets
References: <983264512.3a9b6d0098303@imp.imms.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Christian Schroeder wrote:
>
> Hi all,
>
> did anybody successfully cross compile gdbserver for powerpc targets.
> I tried the sources for gdb-4.18 and gdb-5.0 but gdbserver didn't compile.
>
> Is there a special version of gdbserver for ppc targets or do I have to
> apply patches ?
>

There are indeed patches.  The best place I can point you at is the
MontaVista ftp site.  ftp.mvista.com.  Grab the source package for gdb,
the patches should be in there and their should be a starting point for
you to play with.

(the FTP site also has precompiled stuff, but unless you are using our
tools, it's better for you to recompile.)

--Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
