In-Reply-To: <200003151243.MAA30200@hyperion.valhalla.net>
Date: Wed, 15 Mar 2000 14:15:44 +0100
To: Iain Sandoe <iain@sandoe.co.uk>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Different Mac Models.
Message-Id: <20000315141544.001497@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 15, 2000, Iain Sandoe <iain@sandoe.co.uk> wrote:


>firmware as in local (to the PMU) flash/rom...
>or loaded up from 'system' rom...
>or something else ?

Certainly local. The PMU runs all the time when the machine is plugged
and controls the power to all other HW in the machine, including the CPU.
At least it works this way on the powerbooks. If the PMU has no firmware,
the machine won't even boot.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
