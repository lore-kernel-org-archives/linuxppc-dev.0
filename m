Message-ID: <3A0BFE46.A7366165@snmc.com>
Date: Fri, 10 Nov 2000 07:55:18 -0600
From: Daris A Nevil <dnevil@snmc.com>
MIME-Version: 1.0
To: john zhan <johnzhan@btamail.net.cn>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: GDB for host development platform
References: <006001bf448c$4aee3aa0$57c809c0@fel>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


John,

Sounds as though you did not connect to the target correctly.  I have
written a procedure we use to connect to a PPC target over ethernet.
You can view this at:

	http://qslinux.org/docs/cross/gdb/index.html

Hope this helps.

Regards,
Daris Nevil


john zhan wrote:
>
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
Daris A Nevil
Simple Network Magic Corporation
401 Kentucky Lane
McKinney, TX 75069
214-793-7757
dnevil@snmc.com
www.snmc.com
quickstack.com
qslinux.org

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
