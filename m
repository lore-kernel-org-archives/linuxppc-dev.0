From: Benjamin Herrenschmidt <bh40@calva.net>
To: <mlan@cpu.lu>
Cc: <linuxppc-dev@lists.linuxppc.org>, <andre@linux-ide.org>
Subject: Re: ide_delay_50ms() freezing on PPC?
Date: Tue, 27 Jun 2000 10:30:03 +0200
Message-Id: <20000627083003.23370@mailhost.mipsys.com>
In-Reply-To: <200006262005.WAA00763@piglet.grunz.lu>
References: <200006262005.WAA00763@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jun 26, 2000, Michel Lanners <mlan@cpu.lu> wrote:

>Hi Andre,
>
>On  25 Jun, this message from Andre Hedrick echoed through cyberspace:
>> Then we need braoder stubs.
>> Got a suggestion?
>
>No... before suggesting anything, I'd like to understand why the loop
>doesn't work on PPC (only on PPC?), and why the use of
>schedule_timeout() depends on PCMCIA ide devices....

Michel,

Can you check the generated code for the loop ? Does it actually re-dead
jiffies from memory or not ? (Did the compiler wrongly tried to optimise
it ?).

Also check jiffies is correctly declared volatile

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
