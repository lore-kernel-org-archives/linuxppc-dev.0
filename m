Message-ID: <3B9799AB.58924366@mvista.com>
Date: Thu, 06 Sep 2001 10:43:39 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Bryan Rittmeyer <bryan@ixiacom.com>
Cc: linuxppc-embedded@lists.linuxppc.org, dan@mvista.com
Subject: Re: pthread support in ppc405 gdb
References: <3B96BA46.6040604@ixiacom.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Bryan Rittmeyer wrote:
>
> Hi,
>
> * gdb 5.0
>    gdb 5.0 included with HHL 2.0 does not support
>    debugging multi-threaded (pthread) applications.
>
> What are the problem areas that prevent gdb 5.0 from debugging
> threaded applications on the ppc405? Is anyone on the
> list or within MontaVista willing to work with me to fix
> threading support in gdb?
>
> We are willing to do whatever it takes to get x86-workstation-quality
> gdb on the embedded ppc405 (and, tangentially, the sh4).

The problem is that gdb 5.0 does not have thread support.  This is not
something that is "easily" added to 5.0.  The gdb 5.1 coming out (from
my understanding, I'm not working specifically on gdb, so if I am wrong
I appologize in advance) does have thread support.  From my
understanding it is a pretty significant change.  We have gdb 5.1
testing in house on a few platforms, but I'm not sure about 405.

AFAIK "real" gdb 5.0 on x86 also does not have thread support.  RedHat
or another distro vendor may have grafted x86 thread support in, or it
may partially work... but gdb 5.1 will be the first gdb version to be
released with thread support.

If you have a MontaVista support contract, contact us.  Otherwise, I
don't believe we are planning on releasing the gdb 5.1 work we have done
so far until our next release.

--Mark Hatle
MontaVista Software, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
