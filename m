Message-ID: <4050CF87.9020104@catapult.com>
Date: Thu, 11 Mar 2004 15:43:51 -0500
From: "Kevin A. Sapp" <Kevin.Sapp@catapult.com>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: io space mapping and sync
References: <40486C64.80803@246tNt.com> <4048B287.6010501@246tNt.com> <200403080843.26481.g.jaeger@sysgo.com> <404C5E13.9000700@246tNt.com>
In-Reply-To: <404C5E13.9000700@246tNt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am using an 8275 and map memory.
When I map my LEDS physical 0x40000000 to 0x40000000
using a BAT I can hit them, several minutes into execution
during a sync, the system hangs.

I have tried to map this to a smaller region using the
mmu (io_block_mapping) but when I do the
region is no longer accessable.  THis is the
preferred method as I have a large region at
3000.0000 that I want to map using the remaining
BAT.

What should I do?  Any clues where to search for
an explaination of what is going on?


Thanks
Kevin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
