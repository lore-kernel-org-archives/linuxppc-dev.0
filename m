Subject: Re: Hardware interrupts routines
From: Jeff Angielski <jeff@theptrgroup.com>
To: Garcia =?ISO-8859-1?Q?J=E9r=E9mie?= <GARCIAJ@3il.fr>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <85E6ED5B5EC32F439702305CC417E12D9E2A80@email.3il.fr>
References: <85E6ED5B5EC32F439702305CC417E12D9E2A80@email.3il.fr>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1087393616.4252.11.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 16 Jun 2004 09:46:56 -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2004-06-16 at 10:28, Garcia Jérémie wrote:
> <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
>
> The only hardware interrupts routine I found through my investigations is the
> request_irq(...). But the problem is that request_irq do not allow me to pass
> an argument to the handler... So is there a routine that allows it or is there
> a way to adapt the request_irq() to my case.

Reread the kernel source code.  request_irq() does allow you to pass a
parameter.  Its the last argument to the function.

Jeff Angielski
The PTR Group


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
