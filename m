From: Kwanksuk Kim <kskim@neowave.co.kr>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Remote multi-thread debugging is valid?
Date: Fri, 26 Jan 2001 16:21:42 +0900
Content-Type: text/plain
References: <200101260218.SAA28758@xoommail.com>
In-Reply-To: <200101260218.SAA28758@xoommail.com>
MIME-Version: 1.0
Message-Id: <01012616315400.20862@kskim.neowave.co.kr>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, everyone,

I'd like to debug multi-thread program on my custon board (MPC860) with remote
debugger.

I'm using cross gdb, gdbserver, and kernel from monta vista, (gdb 4.17, linux
2.2.13)

I test test code on my host PC, it works well. But I doesn't work on target

Just after the new thread being created, gdb displays these message,


17          if (pthread_create(&tid, NULL, sayHello, NULL) )
(gdb) s

Program received signal SIGPWR, Power fail/restart.
0xfee0724 in ?? ()
(gdb)

And the gdb doesn't show thread info, like this


(gdb) info thread
warning: RMT ERROR : failed to get remote thread list

(gdb)

Is it impossible to debug multi-thread with remote-debugging?

I'm looking forward to your helps, thanks.

Have a nice weekend!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
