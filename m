Message-ID: <3BC470F6.F429B1ED@prodys.net>
Date: Wed, 10 Oct 2001 18:01:58 +0200
From: Pedro Parrilla <pparrilla@prodys.net>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Using Kgdb...
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


    Hello, first of all, I am using a MBX860 board, with a Motorola
MPC860 processor, and I am debugging a 2.4.7 Kernel with KGDB on this
target from my Intel PC host with DDD via serial line. I'd like to load
a module of mine, and I have to stop Kernel execution from DDD, so I can
load symbols from my module with 'add-symbol-file', but I think that you
have to set a breakpoint to stop the Kernel, you can't use INTERRUPT
(^C)...
    Could anyone tell me how to stop execution of a Kernel with Kgdb
whenever you want, with remote debugging, without having to set a
breakpoint?



--
Pedro Parrilla Jimena           Prodys.S.L
Embedded systems programming    Trigo,54
e-mail pparrilla@prodys.net     Leganes(Madrid) 28914
Tel.:+34916896880               http://www.prodys.net


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
