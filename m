Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f157.google.com (mail-gx0-f157.google.com
	[209.85.217.157]) by ozlabs.org (Postfix) with ESMTP id 1EA51DDE0E
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Mar 2009 01:48:46 +1100 (EST)
Received: by gxk1 with SMTP id 1so6608373gxk.9
	for <linuxppc-dev@ozlabs.org>; Sun, 01 Mar 2009 06:48:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090301101815.GC23093@pengutronix.de>
References: <1235575933-29691-1-git-send-email-w.sang@pengutronix.de>
	<fa686aa40902262131i6c75687foaf42daeb4fc7a3b7@mail.gmail.com>
	<20090301101815.GC23093@pengutronix.de>
Date: Sun, 1 Mar 2009 07:48:44 -0700
Message-ID: <fa686aa40903010648q238380acy34b58e04226d8014@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mpc52xx: add Phytec phyCORE-MPC5200B-IO board
	(pcm032)
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Mar 1, 2009 at 3:18 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> Hi Grant,
>
> thanks for the review!
>
> On Thu, Feb 26, 2009 at 10:31:24PM -0700, Grant Likely wrote:
>> Thanks for the patch Wolfram. =A0Comments below.
>>
>> On Wed, Feb 25, 2009 at 8:32 AM, Wolfram Sang <w.sang@pengutronix.de> wr=
ote:
>> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
>> > ---
>> > =A0arch/powerpc/boot/dts/pcm032.dts =A0 =A0 =A0 =A0 =A0 =A0 | =A0391 +=
++++++
>> > =A0arch/powerpc/configs/52xx/pcm032_defconfig =A0 | 1394 +++++++++++++=
+++++++++++++
>>
>> Do you really need a separate defconfig for this board? =A0Can it be
>> merged with an existing defconfig?
>
> Will have a look if I can make a pcm03x_defconfig out of pcm030_defconfig=
.

Cool, thanks.

>> motionpro.dts is a good example of what it should look like.
>
> Ah, thanks for the pointer. Will have a look there. Guess I'll need to up=
date
> pcm030.dts later, too (from which I copied this one). Will rewrite the
> localbus-node addressing the comments you gave.

pcm030.dts in mainline doesn't have a localbus node.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
