From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Cort Dougan <cort@fsmlabs.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: i8259.c spinlocks unnecessary
Date: Sat, 29 Jun 2002 16:28:33 +0200
Message-Id: <20020629142833.27374@192.168.4.1>
In-Reply-To: <20020629135542.31287@192.168.4.1>
References: <20020629135542.31287@192.168.4.1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>irc.c don't have a global spinlock, only per-desc locks, so you can well
 irq.c

I should sleep more ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
