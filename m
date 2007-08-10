Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 5987CDDEDA
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Aug 2007 00:18:47 +1000 (EST)
Message-ID: <46BC7447.1000105@ru.mvista.com>
Date: Fri, 10 Aug 2007 18:20:55 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: ssaravanan@arasor.in
Subject: Re: i couldn't get display in Console?
References: <380-2200784910242271@M2W022.mail2web.com>
In-Reply-To: <380-2200784910242271@M2W022.mail2web.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello.

ssaravanan@arasor.in wrote:

>  when i am booting montavista kernel using uboot i couldn't get any message
> on Console...
> i can view the booting messages by "Dumping the printk Log Buffer".  i am
> passing the "bootargs=console=ttyS0,115200 root=/dev/ram0 rw"...is that i

    I suspect you should use ttyCPM0 instead of ttyS0. Thi board very likely 
has CPM2, so its UARTs are the only ones that exist.

> have to make any modification in kernel configuration to support
> appropriate serial port for display boot messags.. find the attached printk

    You should enable CONFIG_SERIAL_CPM (if it's not already enabled).

> buffer screen shot? can anybody help?

    You have actually replied only to me, not the maillist

> Regards,
> Saravanan.S

WBR, Sergei
