Date: Thu, 5 Sep 2002 08:03:06 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Shift keycodes on the iBook
To: benh@kernel.crashing.org
Cc: jason@openinformatics.com, eblanton@cs.ohiou.edu,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20020903201753.1227@192.168.4.1>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <E17mpjY-0000DD-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   3 Sep, this message from Benjamin Herrenschmidt echoed through cyberspace:
>>> The interesting thing is that was what was believed for years about
>>> the locking capslock key as well...
>>
>>Ah, but that depends on the specific model of keyboard. At least some of
>>Apple's ADB keyboards _do_ indead have a mechanical capslock.
>>
>>I don't know for USB keyboards, but obviously the PowerBook keyboards
>>have a regular (non-locking) key as capslock. Whether the lock is done
>>in the ADB driver or in the keyboard controller, I don't know...
>
> Actually, the lock itself isn't, but the keycode sent by the PMU behave
> like a HW lock (and the LED is driven that way too).
>
> In both cases, there may be ways to instruct the PMU to behave differently
> but I don't know about them.

Anybody up for sucking the PMU firmware out of the little beast and
reverse-engineering it? Might be a fun project :-))

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
