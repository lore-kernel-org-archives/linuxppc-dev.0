From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>,
	Tom Rini <trini@kernel.crashing.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH and RFC] Remove request_8xxirq
Date: Thu, 20 Jun 2002 18:58:49 +0200
Message-Id: <20020620165849.23834@smtp.wanadoo.fr>
In-Reply-To: <3D12513E.1000905@embeddededge.com>
References: <3D12513E.1000905@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>The other problem is the "namespace" of request_irq() usually assumes
>numbers 0 to 15 are an 8259, and many legacy devices are hardcoded to
>use these numbers.

Not that much actually. Look at pmac, I have nothing even close to
the 0..15 ISA namespace. Of course, a few crappy legacy ISA drivers
are broken, but we don't use them on PMAC, and you can eventually
hack them if you need them on embedded until a proper fix gets done.

BTW. At least serial.c is beeing redesigned by Russel King (ARM) ;)

Ben.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
