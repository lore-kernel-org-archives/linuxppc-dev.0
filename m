Message-ID: <006001bf448c$4aee3aa0$57c809c0@fel>
Reply-To: "john zhan" <johnzhan@btamail.net.cn>
From: "john zhan" <johnzhan@btamail.net.cn>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: GDB for host development platform
Date: Fri, 10 Nov 2000 10:35:10 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have now successfully build GDB-4.18 for linux/ppc.
Both target and host are powerpc-linux.
When I was trying to run a executable in my target
hardware(8xx) with gdb(target for exec),
 e.g. hello,
GDB said
"
Starting program: ./hello
Don't know how to run.  Try "help target".
"
Questions:
    1. what's going on it?
    2. Does(Did) anyone do the same thing?
    3.The cross-debugger + target gdb server with a serial connection
         is the unique choices?
    4. I wonder which is the best way to debug a linux/ppc application
        on the embedded platform.
    5. What do you think a full host development environment
        (including native comilper,debugger etc) in the embedded
        system.

thank for any response.

regards.
john zhan.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
