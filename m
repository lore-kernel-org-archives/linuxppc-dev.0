From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <mlan@cpu.lu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Crash with BenH's 2.4.10/2.4.11-pre on 7600
Date: Mon, 8 Oct 2001 23:24:33 +0200
Message-Id: <20011008212433.29694@smtp.wanadoo.fr>
In-Reply-To: <200110081944.VAA00811@piglet.grunz.lu>
References: <200110081944.VAA00811@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>The problem is that request_OF_resource (which calls kmalloc() ) is
>called from probe_sccs, which in turn is called for the serial console,
>i.e _very_ early in the boot process. At that time, the kmem system is
>not yet initialized.

Good catch !

I'll find a fix.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
