In-Reply-To: <8529B5552D4EAA4DAEDF49650C64B2B437137E@tarpon.mangrovesystems.com>
References: <8529B5552D4EAA4DAEDF49650C64B2B437137E@tarpon.mangrovesystems.com>
Mime-Version: 1.0 (Apple Message framework v609)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <718FB936-4514-11D8-8C1D-000A95A0560C@us.ibm.com>
Cc: "<linuxppc-dev@lists.linuxppc.org>" <linuxppc-dev@lists.linuxppc.org>
From: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: how to read/write registers of CPU or Device from user space
Date: Mon, 12 Jan 2004 09:31:51 -0600
To: <zjzhou@newrocktech.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Jan 12, 2004, at 7:48 AM, Muhammad Sarwar wrote:
>
> From user space access, use mmap.

To elaborate a *little* more, you can mmap /dev/mem to get a view onto
the physical address space. (Note that it won't work for RAM, but
that's not what you're trying to do anyways.)

This won't help you to read the CPU's registers, but what are you
looking for there?

> -----Original Message-----
> From: John Zhou [mailto:zjzhou@newrocktech.com]
> Sent: Sunday, January 11, 2004 9:20 PM
> To: linuxppc-dev@lists.linuxppc.org
> Subject: how to read/write registers of CPU or Device from user space
>
>
> Hi, all,
>
> when debugging kernel or driver, we need to read/write registers of
> CPU and devices. I wanna use /dev/mem to do, is it possible? if need
> to do others things? is it better to write a driver for read/write
> CPU/device's registers by myself?
>
> Do you have any good advice?
>
> Thanks in advance!
> John
>
>
>
>
>
--
Hollis Blanchard
IBM Linux Technology Center


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
