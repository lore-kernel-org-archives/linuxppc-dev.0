Message-ID: <3A0C23CA.13ADFE8A@mvista.com>
Date: Fri, 10 Nov 2000 08:35:22 -0800
From: Cal Erickson <cal_erickson@mvista.com>
Reply-To: cal_erickson@mvista.com
MIME-Version: 1.0
To: john zhan <johnzhan@btamail.net.cn>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: GDB for host development platform
References: <006001bf448c$4aee3aa0$57c809c0@fel>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


John,
Why not take a look at the Cross Development Kit from
MontaVista Software? If you go to their web site you
can download it for free. It comes with GDB and
GDB server which uses the ethernet to debug.

Cal Erickson

john zhan wrote:

> I have now successfully build GDB-4.18 for linux/ppc.
> Both target and host are powerpc-linux.
> When I was trying to run a executable in my target
> hardware(8xx) with gdb(target for exec),
>  e.g. hello,
> GDB said
> "
> Starting program: ./hello
> Don't know how to run.  Try "help target".
> "
> Questions:
>     1. what's going on it?
>     2. Does(Did) anyone do the same thing?
>     3.The cross-debugger + target gdb server with a serial connection
>          is the unique choices?
>     4. I wonder which is the best way to debug a linux/ppc application
>         on the embedded platform.
>     5. What do you think a full host development environment
>         (including native comilper,debugger etc) in the embedded
>         system.
>
> thank for any response.
>
> regards.
> john zhan.
>

--
===========================================================================
Cal Erickson                 MontaVista Software Inc.
Customer Support Engineer    490 Potrero Avenue
Phone (408) 328-0304         Sunnyvale CA 94085
Fax   (408) 328-9204         e-mail cal_erickson@mvista.com
Pager 877-566-2012           support 1-800-759-8888 pin 202-7489
web http://www.mvista.com    support e-mail: support@mvista.com
eCode: http://cal@work.com.ecode.com
===========================================================================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
