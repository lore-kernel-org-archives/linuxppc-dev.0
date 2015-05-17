Return-Path: <dand1972@yahoo.com>
Received: from nm42-vm9.bullet.mail.ne1.yahoo.com
 (nm42-vm9.bullet.mail.ne1.yahoo.com [98.138.120.215])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 706BC1A0213
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 May 2015 18:43:02 +1000 (AEST)
Message-ID: <1431852007.81598.YahooMailBasic@web141505.mail.bf1.yahoo.com>
Date: Sun, 17 May 2015 01:40:07 -0700
From: Dan DeVoto <dand1972@yahoo.com>
Subject: Re: [PATCH] i2c: powermac: don't workaround for keywest
To: wsa@the-dreams.de, Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1431386803.13039.30.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Elliott <txlitebeer@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Sorry for the delay, I found this message in my spam folder.  Anyway,
for my machine model, cat /proc/device-tree/compatible returns:

PowerBook4,3MacRISC2MacRISCPower Macintosh

It's a 14 in. iBook G3 700 MHz.

Regards,

Dan

--------------------------------------------
On Mon, 5/11/15, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

Subject: Re: [PATCH] i2c: powermac: don't workaround for keywest
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "Dan DeVoto" <dand1972@yahoo.com>, "Mark Elliott" <txlitebeer@gmail.com>
Date: Monday, May 11, 2015, 4:26 PM

On Mon, 2015-05-11 at 09:34 +0200, wsa@the-dreams.de wrote:
> On Mon, May 11, 2015 at 08:14:47AM +1000, Benjamin Herrenschmidt wrote:
> > On Sun, 2015-05-10 at 20:34 +0200, Wolfram Sang wrote:
> > > Okay, so this patch is bogus. I understand now that onyx uses another
> > > codec than TAS, so this change will regress on other machines.
> > > However,
> > > it shows that this unconditional instantiation of the TAS breaks sound
> > > on Macintoshs which still need non-aoa sound support. I assume there
> > > will be noone in the near future to convert Keywest to AOA, so we'll
> > > need to find a hackish way around this instantiation problem.
> >

> > Converting the old macs that use TAS shouldn't be *that* hard, main
> > problem is I don't have the hardware to test...
> > Dan and Mark (on CC) have been very helpful with testing. Maybe they are
> > also in to test "the proper solution"?

> Possibly, depends how many machines we can cover. I also have extremely
> little time, so I'm not that keen on volunteering :-) I'll *try* to have
> a look some time this or next week.
>
> The main problem is the difference in the way the layout of the codec
> etc... is reported from the DT by the firmware. Otherwise the HW is the
> same between pre-AOA and post-AOA really ...
>
> I do have a bunch of DT snapshots lying around, so I can try
> to figure out something.
>
> Dan, Mark, what machine models specifically do you have ? (compatible
> property in the DT pls, ie, /proc/device-tree/compatible).
>
> Cheers,
> Ben.
 
 
 
