From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Xavier Grave" <grave@ipno.in2p3.fr>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: just compiled a 2.4.19 kernel with smp support...
Date: Mon, 21 Oct 2002 19:55:07 +0200
Message-Id: <20021021175507.11971@192.168.4.1>
In-Reply-To: <200210211341.PAA17882@ipnmail.in2p3.fr>
References: <200210211341.PAA17882@ipnmail.in2p3.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I've just compiled a 2.4.19 kernel with smp support but when I do a cat
>/proc/cpuinfo I can only see one processor ? Do I need to set something more
>than SMP=y in make config ?
>
>I'm using a debian kernel source package with the patches for powerpc.

Newer machines need my latest tree for SMP

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
