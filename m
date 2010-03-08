Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f184.google.com (mail-yw0-f184.google.com
	[209.85.211.184]) by ozlabs.org (Postfix) with ESMTP id BBBE0B7CED
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Mar 2010 03:54:10 +1100 (EST)
Received: by ywh14 with SMTP id 14so3085547ywh.15
	for <linuxppc-dev@ozlabs.org>; Mon, 08 Mar 2010 08:54:09 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <27310604.1268065948452.JavaMail.ngmail@webmail08.arcor-online.net>
References: <1267978529.2306.0@antares>
	<fa686aa41003071645x70dff5d7s89db66416bcc4a0d@mail.gmail.com>
	<20100308151912.14847a74@wker>
	<27310604.1268065948452.JavaMail.ngmail@webmail08.arcor-online.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 8 Mar 2010 09:53:49 -0700
Message-ID: <fa686aa41003080853q521b4f81s5c7488ebcc8dfb63@mail.gmail.com>
Subject: Re: mpc512x uart: testers wanted
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, agust@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 8, 2010 at 9:32 AM, Albrecht Dre=DF <albrecht.dress@arcor.de> w=
rote:
> Hi Anatolij:
>
>> > Anatolij, could you please look into this?
>>
>> I'll look into this tomorrow, need to finish USB support now.
>> Unfortunately the patch doesn't apply on top of Linus' tree as
>> patches for reworked MPC5121 PSC UART support have been merged.
>> Albrecht, could you please rebase your patch?
>
> Against linux/kernel/git/torvalds/linux-2.6.git? =A0Will do that tomorrow=
... =A0Grant, do you need a patch against Linus' tree, or against a release=
d version, or against your tree?

I won't be picking this up until after -rc1 or -rc2 anyway, and it
won't get merged into Linus' tree until the 2.6.35 merge window, so
I'm not going to even touch it for a couple of weeks.  When I do get
to it I'll need it against Linus' tree.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
