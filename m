In-Reply-To: <030420040336.7499.42eb@comcast.net>
References: <030420040336.7499.42eb@comcast.net>
Mime-Version: 1.0 (Apple Message framework v612)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <24C854FC-6DED-11D8-8994-000393DBC2E8@motorola.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
From: Kumar Gala <kumar.gala@motorola.com>
Subject: Re: MPC8540 Interrupts and u-boot
Date: Thu, 4 Mar 2004 09:03:49 -0600
To: <c.duong@comcast.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The u-boot code does not use the interrupt controller to do any of its
work.  Its all poll based for uart and ethernet.  The Linux kernel side
uses the preexisting openpic code.  (only change is that the registers
are now in big-endian)

- kumar

On Mar 3, 2004, at 9:36 PM, <c.duong@comcast.net> wrote:

>
> Hi,
>
> I'm starting to work with MPC8540 and u-boot.  I'm looking for
> interrupt related code for MPC8540 PIC(programmable interrupt
> controler).  All I can find in the u-boot source code is unimplement
> code and code for MCP8260.  Does anyone know where I can find such
> code?
>
> Thanks in advance for all your help!
> Chau
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
