Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CA2A1DE095
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 07:20:56 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m08KKrDw020530
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 15:20:53 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m08KKruv411910
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 15:20:53 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m08KKrgP023410
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 15:20:53 -0500
Date: Tue, 8 Jan 2008 14:20:48 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] Hwmon for Taco
Message-ID: <20080108142048.4a3951cc@zod.rchland.ibm.com>
In-Reply-To: <20080108201314.GA29127@localhost.localdomain>
References: <477F1196.7000109@pikatech.com> <1199517763.7291.47.camel@pasglop>
	<47831868.3030309@pikatech.com>
	<fa686aa40801072259w63899e74y45d55bd5e9844b68@mail.gmail.com>
	<4783C128.8050103@pikatech.com>
	<20080108130251.7ae351c7@zod.rchland.ibm.com>
	<20080108201314.GA29127@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 8 Jan 2008 23:13:14 +0300
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

[snip mostly valid stuff]

> Yes, it's common sense and politeness to keep Signed-off-by lines
> intact (and the order of these lines), but it's not strict
> requirement. "Based on the patch from ..." is the equivalent of
> this politeness.

You took my statement slightly out of context (or I did a lousy job of
explaining for this case).

Basically, I _know_ that Stefan has S-o-b lines in his tree.  I _know_
he did most of the work, and I _know_ he's fairly agreeable to adding
his S-o-b line to patches he isn't pushing himself.

So I was simply asking if Sean could get Stefan to add his S-o-b as
well.  At the very least a "From:" would be warranted if Sean hasn't
change any code.  Then authorship would still be attributed to Stefan.

Yeah, it might be "politeness" but there's really no reason to be
impolite when all the parties involved are in the same discussion...

josh
