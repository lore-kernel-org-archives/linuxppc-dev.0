Message-ID: <386B8983.AE2F1A5A@wanadoo.fr>
Date: Thu, 30 Dec 1999 17:34:11 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: bob@kunk.jriver.com
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.14pre16 & usb kbd
References: <19991230080950.11540.qmail@kunk.jriver.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


bob@kunk.jriver.com wrote:
> 
> The USB keyboard mapping appears to have changed (or been broken) between
> 2.2.14.pre9 and 2.2.14pre16 from Paul's rsync. (running on an iMac rev C)
> 
> Did I miss something that someone can fill me in on?

On French USB keyboards, these kernels are as broken as they always
were. Could you elaborate what has changed for your keyboard? 

There are some more or less half-baked patches for the USB->ADB
translation in the kernel floating around, but none of them works
correctly on European Apple USB keyboards. I wonder whether the idea
behind this funny translation scheme in the kernel ("translate USB
keycodes to ADB or PC keycodes, so that you can use the same user space
keymaps for USB and ADB or PC keyboards") can work at all.

Right now, it doesn't. There are either unmapped keys or different keys
mapped to the same keycode or, in the best of all cases, exchanged keys.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
