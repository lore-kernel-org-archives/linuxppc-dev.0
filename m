From: benh@kernel.crashing.org
To: Robert E Brose II <bob@kunk.jriver.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: YAM kernel driver IRQ question
Date: Thu, 11 Apr 2002 00:44:20 +0100
Message-Id: <20020410234420.409@mailhost.mipsys.com>
In-Reply-To: <20020411031445.29017.qmail@kunk.jriver.com>
References: <20020411031445.29017.qmail@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I know the board is working OK because I can use setserial on port
>0x890 and irq 24, throw a modem on it and all is well..
>
>What I'm wondering is if anyone who knows about the enabling,
>etc of IRQS on pmacs can tell me if there anything I might have
>to look out for when enabling interrupt 24 as against interrupt 3
>(for example)...

Nothing special here, I beleive you still have a problem in the
driver not liking IRQ 24.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
