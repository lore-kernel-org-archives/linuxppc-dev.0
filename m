Message-ID: <40486C64.80803@246tNt.com>
Date: Fri, 05 Mar 2004 13:02:44 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Linux 2.6 on MPC5200. First port attempt ... Early problems ;(
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I'd like to run a 2.6 on a MPC5200 based board. Even if at first I'll
only use a 2.4 in production, I figured that the sooner I start to test
2.6, the sooner I'll be able to use it with enough stability. So I
started to tweak the 2.6.3 tree to make it boot on my LITE5200.

So, I've written/ported/copied some code for the console, the early
serial debug, ..., added the MPC to cputable.c and modified the
Kconfig/Makefile to build theses.
So far I don't seen anything on the serial console and  apparently, the
call the setup_common_caches ( in the cpu_setup_6xx.S ), never returns.
But the code is an exact copy of the 2.4 version ...

The method I use to trace where the execution goes or not is through the
leds connected to the GPIOs. From what I understood, the MBAR (
0xf0000000 ) is always mapped so I can trace with MMU on or off.

Anyone could give me a clue ?


Sylvain Munaut


PS: I'm not an expert in PPC arch. However, I've done such a port ( 2.4
-> 2.6 ) for an ARM architecture, so I'm not completly new to this
either ( even if ARM and PPC are little alike ... )

PS2: Sorry if it's a duplicate, I just had problems with my mail server
queue and don't know wich mail were 'lost'. After waiting 2h to see it
appear on the list and still nothing, I supposed the first one was lost.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
