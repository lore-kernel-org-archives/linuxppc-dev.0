From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gunnar Larisch <Gunnar.Larisch@softing.com>,
	<linuxppc-dev@lists.linuxppc.org>
Cc: <wd@denx.de>
Subject: Re: memory leak if calling request_irq too often
Date: Thu, 18 Jul 2002 16:35:48 +0200
Message-Id: <20020718143548.29805@192.168.4.1>
In-Reply-To: <20020718162923.A7305@w-la.dhcp.softing.com>
References: <20020718162923.A7305@w-la.dhcp.softing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I found a memory leak, when called request_8xxirq again and again.
>This was already fixed for intel cpus, but the bug still exists in ppc
>code.
>
>You can easily see that the bug exists, if you see multiple directories
>in /proc/irq/ with the same name (drivers which already installed their
>irq-handler).

This have already been fixed in recent PPC kernels.

Thanks anyway,
Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
