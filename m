From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <mlan@cpu.lu>, <jason@openinformatics.com>
Cc: <eblanton@cs.ohiou.edu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Shift keycodes on the iBook
Date: Tue, 3 Sep 2002 22:17:53 +0200
Message-Id: <20020903201753.1227@192.168.4.1>
In-Reply-To: <E17mJEj-00006u-00@piglet.grunz.lu>
References: <E17mJEj-00006u-00@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> The interesting thing is that was what was believed for years about
>> the locking capslock key as well...
>
>Ah, but that depends on the specific model of keyboard. At least some of
>Apple's ADB keyboards _do_ indead have a mechanical capslock.
>
>I don't know for USB keyboards, but obviously the PowerBook keyboards
>have a regular (non-locking) key as capslock. Whether the lock is done
>in the ADB driver or in the keyboard controller, I don't know...

Actually, the lock itself isn't, but the keycode sent by the PMU behave
like a HW lock (and the LED is driven that way too).

In both cases, there may be ways to instruct the PMU to behave differently
but I don't know about them.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
