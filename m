Subject: Re: Desesperatly looking for a intConnect() equivalent routine...
From: David Woodhouse <dwmw2@infradead.org>
To: Garcia =?ISO-8859-1?Q?J=E9r=E9mie?= <GARCIAJ@3il.fr>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <85E6ED5B5EC32F439702305CC417E12D9E2A85@email.3il.fr>
References: <85E6ED5B5EC32F439702305CC417E12D9E2A85@email.3il.fr>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1088502104.4636.181.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Date: Tue, 29 Jun 2004 10:41:44 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 2004-06-28 at 17:51 +0100, Garcia Jérémie wrote:
> Does anyone would have a clue for a newbie in Linux ppc dev please??

You don't explain what you're trying to use it for. But you should
almost certainly be writing a kernel driver, in which case the answer is
request_irq().

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
