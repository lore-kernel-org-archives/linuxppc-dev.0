Message-Id: <v04003a00b6ed2078c77d@[24.70.162.12]>
In-Reply-To: <20010401170418.2024@smtp.wanadoo.fr>
References: <20010402002232.Postino-025103@smtp01.highway.ne.jp>
 <20010402002232.Postino-025103@smtp01.highway.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 1 Apr 2001 13:32:11 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: Fwd: CPU features
Cc: <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 12:04 PM -0500 4/1/2001, Benjamin Herrenschmidt wrote:
[...]
>Tell me what result you get with that.

I got the linux-2.4-benh from rsync.penguinppc.org (I assume this is the
up-to-date one) around noontime today, and got a crash after arch:exit on
my 9600/200mp.

xmon sez:

cpu 0: vector: 300 at pc = c0006c18, lr = c01c3518, msr = 1032, sp =
c01a3320 [c01a3270]
dar = cc000000, dsisr = 40000000
current = c01a14a0, pid = 0, comm = swapper
0:mon> t
backtrace c01c33ec c01c0a40 c01c06b4 36b0

One sec while I reboot and check the System.map...

c0006c18 (pc) is in flush_icache_range
c01c3518 (lr) is in pmac_pic_init
co1a14a0 (current) is init_task_union
c01c33ec (bt) is in pmac_pic_init
c01c0a40 (bt) is in init_IRQ
c01c06b4 (bt) is in start_kernel


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
