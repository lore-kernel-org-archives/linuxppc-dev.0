Date: Tue, 3 Sep 2002 21:21:08 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Shift keycodes on the iBook
To: jason@openinformatics.com
Cc: benh@kernel.crashing.org, eblanton@cs.ohiou.edu,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <87znuzksx9.fsf@openinformatics.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <E17mJEj-00006u-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   3 Sep, this message from Jason E. Stewart echoed through cyberspace:
>> >Is this a hardware limitation, or just a limitation of the current
>> >maps?  If it is the latter, can it be easily fixed?  I'm willing to
>> >provide whatever information is necessary if the problem is just that
>> >the appropriate developer needs information about the iBook keyboard.
>>
>> AFAIK, it's a HW limitation (or at least a limitation of the PMU's
>> firmware), there is no workaround I know about.
>
> The interesting thing is that was what was believed for years about
> the locking capslock key as well...

Ah, but that depends on the specific model of keyboard. At least some of
Apple's ADB keyboards _do_ indead have a mechanical capslock.

I don't know for USB keyboards, but obviously the PowerBook keyboards
have a regular (non-locking) key as capslock. Whether the lock is done
in the ADB driver or in the keyboard controller, I don't know...

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
