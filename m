Return-Path: <leigh@solinno.co.uk>
Received: from titan.server-plant.co.uk (titan.server-plant.co.uk [80.71.3.50])
	by ozlabs.org (Postfix) with ESMTP id 3CED62BF07
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Jan 2005 22:17:38 +1100 (EST)
Message-ID: <45605.195.212.29.91.1104923845.squirrel@195.212.29.91>
In-Reply-To: <855e88d005010420367a92617a@mail.gmail.com>
References: <855e88d005010405417d49dcfb@mail.gmail.com>
	<200501041523.j04FNoO0009594@arbas.nms.ulrich-teichert.org>
	<855e88d005010407396309a9f9@mail.gmail.com>
	<855e88d005010420367a92617a@mail.gmail.com>
Date: Wed, 5 Jan 2005 11:17:25 -0000 (GMT)
From: "Leigh Brown" <leigh@solinno.co.uk>
To: mikemartin@linux.ca
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: Ulrich Teichert <krypton@ulrich-teichert.org>, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org, Philippe Guyot <pguyot@cvf.fr>
Subject: Re: 43p-140 install issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mike Martin said:
> On Tue, 4 Jan 2005 10:39:41 -0500, Mike Martin <sydneymartin@gmail.com>
> wrote:
>> On Tue, 4 Jan 2005 16:23:50 +0100 (MET), Ulrich Teichert
>> > Could you try to format them before dd'ing on them, like fdformat
>> /dev/fd0h1440?
>> > I am not sure if that will change anything, though.
>>
>> Will do.
>
> Done - no difference. Same message. Written multiple images, multiple
> times on multiple machine. Each one with the same result. At least I'm
> not completely alone, I found this:
> http://wikihip.cern.ch/twiki/bin/view/RS6000/KernelTestsOn43P240 exact
> same error.

I think I know what's going on here.  What boot arguments are you using?
You should have "load_ramdisk=1" in there somewhere at the very least.

Cheers,

Leigh.
