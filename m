Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f223.google.com (mail-gx0-f223.google.com
	[209.85.217.223]) by ozlabs.org (Postfix) with ESMTP id BB5B1B6F18
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Dec 2009 06:50:27 +1100 (EST)
Received: by gxk23 with SMTP id 23so282411gxk.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Dec 2009 11:50:25 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <200912151159.40628.roman.fietze@telemotive.de>
References: <200912081339.50722.roman.fietze@telemotive.de>
	<fa686aa40912102213m5b2a0092i3c25d73b914ece93@mail.gmail.com>
	<200912151159.40628.roman.fietze@telemotive.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 15 Dec 2009 12:50:05 -0700
Message-ID: <fa686aa40912151150o64f97533h1b736b4445301192@mail.gmail.com>
Subject: Re: [PATCH] PowerPC: const intspec pointers
To: Roman Fietze <roman.fietze@telemotive.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 15, 2009 at 3:59 AM, Roman Fietze
<roman.fietze@telemotive.de> wrote:
> Hallo Grant,
>
> On Friday 11 December 2009 07:13:45 Grant Likely wrote:
>
>> BTW, if you're interested, there is a driver for the SCLPC FIFO about
>> to be merged into 2.6.33. =A0It's in Ben's tree waiting to be pulled
>> into mainline.
>
> I've had a "look" into it. This means I rewrote it in some parts to
> get it running.
>
> First I tried to do it in nice little steps, so the git commits are
> clean and simple. But with my knowldege about the SCLPC, the code your
> old SCLPC test driver and my 2.4.25 FPGA driver using SCLPS and
> BestComm, one of the commits just got a big rewrite including fixes
> for quite some bugs.
>
> The driver is now running using DMA TX and RX. Without BestComm it's
> running partly. I'm really windering if this code ever ran before?
> There are some historical or future items in there like measurement of
> the times, a list_header maybe for future request queueing, and so on

Yes, I'm using the driver in a couple of projects.  It works for me
for both RX and TX (although TX+DMA has been troublesome).  I'll
double check to make sure I've merged all of my patches for the
driver.

The test driver on the other hand is pretty poor code.  Don't expect
much from it other than some hints.  There's a reason I didn't merge
that chunk.

> If you or Ben are interested in my work I can post the patches
> here. Of course just to get some comments, because the driver can't be
> ready in the state it is. The commits would go on top of Ben's next
> branch.

Yes, please post the patches and cc: me.  I'll review, test, and make comme=
nts.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
