Return-Path: <sydneymartin@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.193])
	by ozlabs.org (Postfix) with ESMTP id 4E7F92BDB5
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jan 2005 01:07:33 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 69so74938wra
	for <linuxppc-dev@ozlabs.org>; Mon, 03 Jan 2005 06:07:32 -0800 (PST)
Message-ID: <855e88d0050103060766b09bd0@mail.gmail.com>
Date: Mon, 3 Jan 2005 09:07:31 -0500
From: Mike Martin <sydneymartin@gmail.com>
To: Sven Luther <sven.luther@wanadoo.fr>
In-Reply-To: <20050103140102.GA9197@pegasos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <20050101150055.GA15400@pegasos>
	<200501011630.j01GUP1R007603@arbas.nms.ulrich-teichert.org>
	<20050101165758.GA18559@pegasos>
	<855e88d00501011715633922b2@mail.gmail.com>
	<855e88d0050102201540148511@mail.gmail.com>
	<20050103070535.GA1644@pegasos>
	<855e88d0050103053915c385ec@mail.gmail.com>
	<20050103140102.GA9197@pegasos>
Cc: Ulrich Teichert <krypton@ulrich-teichert.org>, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org
Subject: Re: 43p-140 install issues
Reply-To: mikemartin@linux.ca
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 3 Jan 2005 15:01:02 +0100, Sven Luther <sven.luther@wanadoo.fr> wrote:

[snip]
> What exact machine do you have again ?

An IBM 7043. It's a 43p-140 labeled as a 604e 332 Mhz.

[snip]

> 
> set <minor> <flag> <on|off>
> 
> minor is the partition, starting at 1, flag is the flag, (prep in this case)
> and on|off is obvious.
> 
> It simply sets the prep flag, which is then translated as a 0x41 partition
> type. I think this is a deficiency in the parted/libparted API, but well,
> there is not much we can do about that unless a major libparted change.

Cool. That's good to know.

[snip]

> Yep, d-i uses devfs, still partitions start at 1.

Ok. Oops

> > I see how much more time I can buy with this machine. It may need to
> > go back into storage this week if I can't make it run. Not fun.
> 
> What about donating it to debian or something such ?

I'd love to however it's not mine to donate. It's the companies (They
have 2 actually, I might try the other one since it has slightly
different hardware).

The problem is: at work, I can't netboot. There is no server that will
respond and I can't set one up. I had the machine at home for the
holidays and thus can boot it from my LAN. If I can't get it to
self-boot before I have to take it back to the office - then I'm
stuck.

If I can get it to boot the system (even from floppy or cd) I will
have it to help test stuff. Otherwise it goes back under the desk
where it came from.

MikeMartin
