From: Benjamin Herrenschmidt <bh40@calva.net>
To: Martin Costabel <costabel@wanadoo.fr>
Cc: <linuxppc-dev@lists.linuxppc.org>, <paulus@linuxcare.com.au>
Subject: Re: Patches for 2.4.0-test7
Date: Sun, 27 Aug 2000 00:36:03 +0200
Message-Id: <20000826223603.5117@192.168.1.10>
In-Reply-To: <39A8379C.E4EBB33A@wanadoo.fr>
References: <39A8379C.E4EBB33A@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>I wouldn't mind changing the keymaps, but I really would like to use the
>same keymaps for 2.2.x kernels, for 2.4.0-test kernels with
>CONFIG_ADB_KEYBOARD and with CONFIG_INPUT_ADBHID.

Well, my kernel for now are the only 2.2 to contain the new stuff and
support for linux keycodes. It's currently a different implementation
than the one in 2.4. I beleive that at a given point in the future, we'll
inherit from the 2.4 version in our 2.2 kernels via the USB backport.

>Yes, it is still there, I just verified. There must be some difference
>between Paul's kernel and the bitkeeper tree that causes this. Here is
>another strange observation:
>
>I type "printenv", and LD_LIBARY_PATH is listed with the other env
>variables (with "env", it does not get listed). Now I use the newly
>recovered strace (see below) to try to understand what printenv does
>differently from env. Well, "strace printenv" does not show
>LD_LIBARY_PATH any more!

Ok, I'll look if I see something, but we are in parts of the kernel here
that I don't know very well. Paul, any idea ?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
