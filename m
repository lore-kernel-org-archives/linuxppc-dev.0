From: linas@austin.ibm.com
Date: Wed, 14 Jan 2004 18:13:50 -0600
To: valvoline <valvoline@vrlteam.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Broadcom BCM94306
Message-ID: <20040114181350.B40506@forte.austin.ibm.com>
References: <20040114161107.GM2658@adapter.n0skillz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040114161107.GM2658@adapter.n0skillz.org>; from valvoline@vrlteam.org on Wed, Jan 14, 2004 at 05:11:07PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 14, 2004 at 05:11:07PM +0100, valvoline wrote:
> of drivers are required? i think that simple win32-drivers cannot work
> properly in a different architecture with different *endian.

totally irrelevent and off-topic, but ... the ppc can (or used
to be able to) switch endianess dynamically.  To be more correct,
it can run some user-space code that was little endian, by having
the kernel set the appropriate bit in the MSR before it ran the
app.  I have no idea is the linux kernel saves/restores this bit(s),
or if this is still supported on the newest processors.

--linas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
