Message-ID: <3BA9FD0F.9293D4C3@mvista.com>
Date: Thu, 20 Sep 2001 07:28:31 -0700
From: Cal Erickson <cal_erickson@mvista.com>
Reply-To: cal_erickson@mvista.com
MIME-Version: 1.0
To: Pedro Parrilla <pparrilla@prodys.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problems with remote debugging on MBX860
References: <3BA8C207.79FFF7CD@prodys.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pedro,
All  you need to add is the -ggdb option after the -g in your build of
your application. This option provides gdb with more information
about local variables that -g cannot. Everything else should be fine.
If you were going to debug a kernel using gdb you would not be
using gdbserver.

Cal Erickson
Pedro Parrilla wrote:

>  Hello!
>
>     I am debugging  a remote target (Hard Hat Linux on a MBX860) from my
>
> host (Red Hat Linux 7.0 on x86 PC) with ppc_8xx_gdb(cross-dev). I got to
> connect both with
> 'target extended-remote' directive in the host, and with gdbserver in
> the target, gdb can do STEP,RUN...and the like, but I can't see the
> variables values. If I try to print any local variable GDB response is
> 'incomplete type'. I've compiled with ppc_8xx-gcc and the 'g' option and
> I've  loaded the program in GDB with file 'program'...I don't Know what
> more I should do...Any bad
> configuration?
>
>  Thanks.
>

--
===========================================================================
Cal Erickson                 MontaVista Software Inc.
Linux Consultant             1237 E. Arques Ave.
Phone (408) 328-0304         Sunnyvale CA 94085
Fax   (408) 328-9204         web http://www.mvista.com
===========================================================================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
