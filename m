Date: Mon, 28 Aug 2000 12:43:55 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Martin Costabel <costabel@wanadoo.fr>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Patches for 2.4.0-test7
In-Reply-To: <20000828093449.32188@192.168.1.10>
Message-ID: <Pine.LNX.4.10.10008281239570.28749-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >When I go back to a kernel without new input layer, I have to change all
> >this back. This wouldn't be necessary if drivers for both /dev/adbmouse
> >and /dev/input/mice could coexist..
>
> Well, that's the reason why I originally wanted this compatibility code.
> However, after more thinking, I figured out that if we do that, all it
> will result is yet another configuration mess with users and more support
> emails ;)

We'll have the configuration mess either way. And few things are as
frustrating as answering the question 'why does the screen just keep
flashing on me when I boot this new 2.4 kernel, and how do I fix it' a
hundred times.

> Note that you can have the new input layer with 2.2 using my kernels. I

Which has working adbmouse if you remove all #ifndef INPUT_MOUSEDEV and
corresponding #endif in adbmouse.c.

> still have to verify what's up with Vojtech, but I beleive the input
> layer is part of the USB backport, meaning that future "kernel.org"
> 2.2s+backport will provide the same functionality as 2.4.

Meaning that functionality will be lost ... thanks for the warning.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
