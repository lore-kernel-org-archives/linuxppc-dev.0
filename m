Message-ID: <001001c2926f$c29d2960$370da8c0@aman>
From: "Aman" <aman@mistralsoftware.com>
To: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Debuging Problem in PPC440GP
Date: Sat, 23 Nov 2002 03:10:22 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All

I wanted to debug the application in ppc440gp. To debug I am using gdbserver
and ddd. The application which I have written is hello world program. In the
target the command is

root@192.168.13.246:~# gdbserver 192.168.13.242:4000 hello
Process hello created; pid = 107

In the host the command is
ddd --debugger ppc_405-gdb --gdb hello and then in the GUI the following
command is given

target remote 192.168.13.246:4000 which in turn creates the following line
in the target
Remote debugging using 192.168.13.242:4000

In the above situation , if I say "cont" , the program executes normally.
However if I say "run" , it gives the following error

(gdb) run
Don't know how to run.  Try "help target".

and in the target it says

"Killing inferior".

Can anybody help me in solving this issue.

Thanking you in advance
Regards
Aman


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
