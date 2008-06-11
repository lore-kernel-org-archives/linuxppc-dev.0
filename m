Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id 97815DE028
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 23:30:38 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so643896anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 06:30:36 -0700 (PDT)
Message-ID: <fa686aa40806110630t413aa7a2wcc3c223f306349b6@mail.gmail.com>
Date: Wed, 11 Jun 2008 07:30:35 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David Jander" <david.jander@protonic.nl>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] prtlvt board support (MPC5121e) added
In-Reply-To: <200806111141.16901.david.jander@protonic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200806101842.36755.david@protonic.nl>
	<fa686aa40806101337k45fc0b1bm95a6dc49541bcd66@mail.gmail.com>
	<200806111141.16901.david.jander@protonic.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 11, 2008 at 3:41 AM, David Jander <david.jander@protonic.nl> wrote:
> On Tuesday 10 June 2008 22:37:18 you wrote:
>> Thanks for the patch, comments below.
>> > --- /dev/null
>> > +++ b/arch/powerpc/platforms/512x/prtlvt.c
>>
>> Looks like you've just duplicated mpc5121_ads.c.  You should just add
>> your boards name to the mpc5121_ads_probe function.  Bonus points if
>> you rename the .c file to something more generic.  You only need a new
>> board file if your board needs something special.
>
> Well, it looks like mpc5121_ads.c is pretty generic. The MPC5121 is almost
> a "motherboard-in-a-chip" type of SoC, so there isn't much board-specific
> stuff anywhere. IO-control register setup should be done in the boot-loader.
> What should we do about this then? Rename the whole mpc5121_ads stuff to
> something more generic? What about calling it "mpc5121_generic.c"?

mpc5121_generic.c works for me.

> Btw, you posted this to linucppc-dev mailing list, but I think that was a
> mistake, since this is clearly an embedded processor, so I removed the CC.

Nope, not a mistake.  Discussions on embedded stuff is welcome on the
linuxppc-dev mailing list.  There has been some talk of removing the
linuxppc-embedded list entirely.  I've added the list back to the to:
list.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
