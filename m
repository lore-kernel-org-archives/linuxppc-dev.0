Return-Path: <leigh@solinno.co.uk>
Received: from titan.server-plant.co.uk (titan.server-plant.co.uk [80.71.3.50])
	by ozlabs.org (Postfix) with ESMTP id B8D512BF0E
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Jan 2005 21:00:57 +1100 (EST)
Message-ID: <40750.195.212.29.91.1104919245.squirrel@195.212.29.91>
In-Reply-To: <200501051049.19225.pguyot@cvf.fr>
References: <33721.82.10.231.190.1104781370.squirrel@82.10.231.190>
	<33151.82.10.231.190.1104878355.squirrel@82.10.231.190>
	<20050105090318.GA12317@pegasos> <200501051049.19225.pguyot@cvf.fr>
Date: Wed, 5 Jan 2005 10:00:45 -0000 (GMT)
From: "Leigh Brown" <leigh@solinno.co.uk>
To: "Philippe Guyot" <pguyot@cvf.fr>
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

Philippe Guyot said:
> On Wednesday 05 January 2005 10:03, Sven Luther wrote:
>> On Tue, Jan 04, 2005 at 10:39:15PM -0000, Leigh Brown wrote:
[...]
>> > The PReP specs says that the cards should be initialised to a
>> > minimum resolution of 640x480 iirc.  The boot loader has code to
>> > manually reprogram the card *back* into VGA text mode, but only
>> > for a very limited number of cards.  So, if your card is not
>> > supported by fbdev, and isn't one of the very few supported
>> > cards in the boot loader, it simply won't work under PReP.
>>
>> Ah, ok ... Well i have a cirrus logic card also, and it seems to work. I
>> have anot yet tried the matrox cards though. Do they need to be special
>> cards with forth rom, or will any do ?
>
> Well, my box seems to have a matrox video card and I did the install with
> my graphical console, not the tty.
[...]

That's because your Matrox card is fully supported by fbdev.

Cheers,

Leigh.
