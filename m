Return-Path: <leigh@solinno.co.uk>
Received: from titan.server-plant.co.uk (titan.server-plant.co.uk [80.71.3.50])
	by ozlabs.org (Postfix) with ESMTP id E84212BF11
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Jan 2005 09:39:29 +1100 (EST)
Message-ID: <33151.82.10.231.190.1104878355.squirrel@82.10.231.190>
In-Reply-To: <20050104222854.GA30919@pegasos>
References: <33721.82.10.231.190.1104781370.squirrel@82.10.231.190>
	<200501032211.j03MB7A1021340@arbas.nms.ulrich-teichert.org>
	<20050104222854.GA30919@pegasos>
Date: Tue, 4 Jan 2005 22:39:15 -0000 (GMT)
From: "Leigh Brown" <leigh@solinno.co.uk>
To: "Sven Luther" <sven.luther@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: Ulrich Teichert <krypton@ulrich-teichert.org>, linuxppc-dev@ozlabs.org,
	mikemartin@linux.ca, debian-powerpc@lists.debian.org
Subject: Re: 43p-140 install issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sven Luther said:
> On Mon, Jan 03, 2005 at 11:11:06PM +0100, Ulrich Teichert wrote:
>> Hi,
>>
>> >Delete the "console=tty0", so you end up with:
>> >
>> > Linux/PPC load: console=ttyS0,9600 root=/dev/ram
>> >
>> >and try again!
>> [del]
>>
>> Right, then the installer knows what to do. I think this should go into
>> the Debian installation docs, there are a lot of boxes with graphic
>> cards
>> out which are not supported by Linux.
>
> Err, it should default to vga tedxt mode if the graphic card fbdev is not
> builtin, at least it does it here.

The PReP specs says that the cards should be initialised to a
minimum resolution of 640x480 iirc.  The boot loader has code to
manually reprogram the card *back* into VGA text mode, but only
for a very limited number of cards.  So, if your card is not
supported by fbdev, and isn't one of the very few supported
cards in the boot loader, it simply won't work under PReP.

[...]

Cheers,

Leigh.
