From: Benjamin Herrenschmidt <bh40@calva.net>
To: <mlan@cpu.lu>
Cc: <schmitz@opal.biophys.uni-duesseldorf.de>, <geert@linux-m68k.org>,
        <linuxppc-dev@lists.linuxppc.org>, <paulus@linuxcare.com>
Subject: Re: MacSerial and Serial driver cohabitation
Date: Fri, 28 Jul 2000 10:37:43 +0200
Message-Id: <20000728083743.21545@mailhost.mipsys.com>
In-Reply-To: <200007252156.XAA00879@piglet.grunz.lu>
References: <200007252156.XAA00879@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Hi all,
>
>On  17 Jul, this message from Michael Schmitz echoed through cyberspace:
>> I'd say agree on a fixed order of probing, allocate minors in that order
>> (with the possible exception of allowing a driver to allocate specific
>> minors out of order if someone wants to make sure their driver always
>> gets the same minors).
>
>Whoever fixes this problem should be decorated, and a statue put up in
>his memory. ;-)
>
>But if anyone is brave enough to attempt it, don't forget that there are
>_two_ places where serial ports are probed for: serial console init very
>early in the booting, and driver init much later in the boot process.
>Those two should be guaranteed to be in sync re minor assignment/device
>naming. Right now, that's not the case.

My current rsync tree contains a fix done by Andreas Tobler that helps
cohabitation of macserial and legacy serial. I know Paul and Theodore
have been working on a more definitive fix, I don't know it's status however,

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
