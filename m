Subject: Re: Debuging Problem in PPC440GP
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
To: Aman <aman@mistralsoftware.com>
Cc: Linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <001001c2926f$c29d2960$370da8c0@aman>
References: <001001c2926f$c29d2960$370da8c0@aman>
Content-Type: text/plain
Date: 25 Nov 2002 09:48:54 +0100
Message-Id: <1038214134.929.19.camel@spawn>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2002-11-22 at 22:40, Aman wrote:
>
> Hi All
>
> I wanted to debug the application in ppc440gp. To debug I am using gdbserver
> and ddd. The application which I have written is hello world program. In the
> target the command is
>
> root@192.168.13.246:~# gdbserver 192.168.13.242:4000 hello
> Process hello created; pid = 107
>
> In the host the command is
> ddd --debugger ppc_405-gdb --gdb hello and then in the GUI the following
> command is given
>
> target remote 192.168.13.246:4000 which in turn creates the following line
> in the target
> Remote debugging using 192.168.13.242:4000
>
> In the above situation , if I say "cont" , the program executes normally.
> However if I say "run" , it gives the following error
>
> (gdb) run
> Don't know how to run.  Try "help target".
>
> and in the target it says
>
> "Killing inferior".
>
> Can anybody help me in solving this issue.

Solve what? from the output it's clear that gdbserver already created
the process and since it's already running you can just use continue.

Also the remote protocol is very low level it dose not know how to start
a program.

--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 404 71 83
Borgafjordsgatan 9                Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@etx.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
