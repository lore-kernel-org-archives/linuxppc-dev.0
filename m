Message-ID: <3981D61A.5F3558EB@embeddededge.com>
Date: Fri, 28 Jul 2000 14:51:06 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Steven Tarr <tarr@lucent.com>
CC: LINUXPPC <linuxppc-embedded@lists.linuxppc.org>, support@mvista.com
Subject: Re: initrd >4MB?
References: <3980846B.5B9ADB0B@lucent.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Tarr wrote:

> ... I look in drivers/block/rd.c  and there is a hardcoded
> variable there of 4096.

You can either modify this value (which I did for a long time :-),
or simply add 'ramdisk=xxxx' to the kernel command line.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
