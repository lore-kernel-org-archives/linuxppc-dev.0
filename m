Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id 315D5DDDFC
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Dec 2007 13:55:54 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so4656742wag.13
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Dec 2007 18:55:52 -0800 (PST)
Message-ID: <9e4733910712261855p74a64c48pc7e89ebdd97d4a76@mail.gmail.com>
Date: Wed, 26 Dec 2007 21:55:51 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Siva Prasad" <sprasad@bivio.net>
Subject: Re: Device node - How does kernel know about it
In-Reply-To: <D83235F0F3C86D4D889D8B9A0DA8C6D7012AF958@corpexc01.corp.networkrobots.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <D83235F0F3C86D4D889D8B9A0DA8C6D7012AF958@corpexc01.corp.networkrobots.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/26/07, Siva Prasad <sprasad@bivio.net> wrote:
> Hi,
>
> I am really interested in finding out how kernel knows about device
> nodes and how the whole thing work. This is as part of my debugging
> effort on 8641D based PowerPC board.
>
> * It all started with the problem of "not printing" any thing that comes
> from ramdisk (echo and printf statements), while kernel printk's work
> perfectly fine.
> * Ramdisk is also executing fine, just that prints are not coming out of
> serial. I can see the execution of various user programs with a printk
> in sys_execve() routine. Ramdisk has all the required files like
> /dev/console, /dev/ttyS0, etc.

Does adding console=ttyS0,baud to the kernel boot command line fix it?

-- 
Jon Smirl
jonsmirl@gmail.com
