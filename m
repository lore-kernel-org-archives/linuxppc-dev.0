Message-Id: <20010401213009.Postino-020381@smtp01.highway.ne.jp>
Date: Sun, 1 Apr 2001 21:30:09 +0900
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: Fwd: CPU features
In-Reply-To: <20010331171433.11295@smtp.wanadoo.fr>
References: <20010401003513.Postino-002933@smtp01.highway.ne.jp>
 <20010331171433.11295@smtp.wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> Please tell me if the dual G4 kicks properly the other CPU as
> I changed the way it's done but didn't have a chance to test my
> new code yet.

I tried your tree as SMP-kernel which has also spin_lock problem.
All recent kernel sources have spin_lock problem.

When I used the patch,The kernel boot stop displaying
at "smp_core99_kick_cpu".

The patch here is
http://lists.linuxppc.org/listarcs/linuxppc-dev/200103/msg00259.html

Kaoru


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
