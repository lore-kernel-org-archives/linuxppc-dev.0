Message-ID: <3BCF6F0A.F83DB82D@kegel.com>
Date: Thu, 18 Oct 2001 17:08:42 -0700
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: autoconf and cross-compiling?
References: <20011018233528.6F09E10CC5@denx.denx.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Someone wrote:
> This helps in some situations, but does  only  part  of  the  job  in
> others.  In general, autoconf/automake based stuff will fail to build
> more or less completely when it comes to situations where it tries to
> get information of the (supposed target) system by trying to run some
> test programs.
>
> Either it uses the cross compiler to build the test programs - the it
> dies because these programs cannot be run on the host system;  or  it
> uses  the native compiler and it dies later (sometimes REALLY late on
> the target) because it gathers information from the build host  which
> does  not apply on the target (simple case: getting information about
> endianess when building on a x86 host for a PPC target).
> ...
> There was another posting about this issue by Magnus Damm, see
> http://lists.linuxppc.org/linuxppc-embedded/200109/msg00355.html

Thanks for the link!

I believe there's a fix for the endian problem; see
http://www.gnu.org/software/ac-archive/Cross_Compilation/ac_c_bigendian_cross.html

A similar approch should work for sizeof, shouldn't it?

Don't know about the other ones, like fork etc. :-(

- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
