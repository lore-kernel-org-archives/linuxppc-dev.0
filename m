From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Taylor Holliday <wtholliday@ucdavis.edu>,
        linuxppc-dev
 <linuxppc-dev@lists.linuxppc.org>
Subject: Re: quad 604 SMP (forgot to mention)
Date: Tue, 23 Jan 2001 09:29:24 +0100
Message-Id: <19341218020108.3892@mailhost.mipsys.com>
In-Reply-To: <BHEOKMKGNHLELMKKJJIGMECPCAAA.wtholliday@ucdavis.edu>
References: <BHEOKMKGNHLELMKKJJIGMECPCAAA.wtholliday@ucdavis.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>oops, i forgot the hardware info (wouldn't want you guys searching for my
>previous posts)
>
>daystar genesis mp 600 - 4x604 @ 150 - 216 mb ram
>2 gig quantum atlas hd, 8 gig quantum fireball
>the quad board is PSURGE_QUAD_COTTON for those in the know

Weird.. that same kernel work fine for another Quad user.

I suppose you are booting with BootX ? What PCI cards do you have in the
machine ? Did you try booting with BootX extension instead of the
application ? What version of MacOS are you using ? Did you try booting
with Open Firmware (quik) ?

>the oops message is:
>Oops: kernel access of bad area, sig: 11
>TASK = c01fa4c0[0] 'swapper' Last syscall: 120

Please, note the other oops infos (NIP (PC), etc...) and lookup them in
System.map. Without that, I can't tell you what's wrong.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
