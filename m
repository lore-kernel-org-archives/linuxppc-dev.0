Date: Fri, 14 May 2004 16:23:27 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Andriy Korud <a.korud@vector.com.pl>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Status of 2.6 kernel?
Message-ID: <20040514162327.B30155@home.com>
References: <80908CC5B2C9DB47AAF8C77892FCB44315F774@lion.vector.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <80908CC5B2C9DB47AAF8C77892FCB44315F774@lion.vector.com.pl>; from a.korud@vector.com.pl on Fri, May 14, 2004 at 04:01:45PM +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, May 14, 2004 at 04:01:45PM +0200, Andriy Korud wrote:
>
> Hi, does anybody know status of 2.6.x kernels for PowerPC/embedded (405)? In kernel config there are corresponding options?

There is a tree, bk://source.mvista.com/linux-2.5-ocp, that has most
4xx boards working, but it's 2.6.5.  The core 4xx support is moving into
current 2.6, but it will be a little bit longer until important drivers
like EMAC and IIC are merged into the stock kernel.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
