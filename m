From: Benjamin Herrenschmidt <bh40@calva.net>
To: Martin Costabel <costabel@wanadoo.fr>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Keyboard trouble with XF 4.0.1
Date: Sun, 22 Oct 2000 22:53:01 +0200
Message-Id: <19340916142445.23209@192.168.1.10>
In-Reply-To: <39F33A92.751C5F@wanadoo.fr>
References: <39F33A92.751C5F@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Then, with ADB keycodes, the key left of '1' and the one right to
>> 'Shift_L' are swapped vs. my previous setup. Is it now 'the right way'?
>> Could be, since the default US map I got with X was right... So I guess
>> those keys have been swapped in the 'old' code for ages.
>
>Looks to me like an arbitrary decision. But since it is Franz and Ben
>who have decided that the kernels and maps that we have used for years
>were wrong, we will have to accept this decision.

That's not that we decided our keymaps were wrong (well, they had a few
things wrong). No, the major issue is to have keycode consistency among
various archs and various PPC machines. There's no reason why the same
USB keyboard would give different keycodes depending if your machine is
considered as a pmac or not.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
