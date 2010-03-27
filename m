Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f221.google.com (mail-gx0-f221.google.com
	[209.85.217.221]) by ozlabs.org (Postfix) with ESMTP id CBDFAB6ED0
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Mar 2010 13:10:58 +1100 (EST)
Received: by gxk21 with SMTP id 21so506972gxk.2
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 19:10:56 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <fa686aa41003080853q521b4f81s5c7488ebcc8dfb63@mail.gmail.com>
References: <1267978529.2306.0@antares>
	<fa686aa41003071645x70dff5d7s89db66416bcc4a0d@mail.gmail.com>
	<20100308151912.14847a74@wker>
	<27310604.1268065948452.JavaMail.ngmail@webmail08.arcor-online.net>
	<fa686aa41003080853q521b4f81s5c7488ebcc8dfb63@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 26 Mar 2010 20:10:36 -0600
Message-ID: <fa686aa41003261910uf5c3612pf275d034237ba997@mail.gmail.com>
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

On Mon, Mar 8, 2010 at 9:53 AM, Grant Likely <grant.likely@secretlab.ca> wr=
ote:
> On Mon, Mar 8, 2010 at 9:32 AM, Albrecht Dre=DF <albrecht.dress@arcor.de>=
 wrote:
>> Hi Anatolij:
>>
>>> > Anatolij, could you please look into this?
>>>
>>> I'll look into this tomorrow, need to finish USB support now.
>>> Unfortunately the patch doesn't apply on top of Linus' tree as
>>> patches for reworked MPC5121 PSC UART support have been merged.
>>> Albrecht, could you please rebase your patch?
>>
>> Against linux/kernel/git/torvalds/linux-2.6.git? =A0Will do that tomorro=
w... =A0Grant, do you need a patch against Linus' tree, or against a releas=
ed version, or against your tree?
>
> I won't be picking this up until after -rc1 or -rc2 anyway, and it
> won't get merged into Linus' tree until the 2.6.35 merge window, so
> I'm not going to even touch it for a couple of weeks. =A0When I do get
> to it I'll need it against Linus' tree.

Ping?  I was looking at this tonight but it of course doesn't apply.
Have you gotten a chance to rebase this patch yet?

Thanks,
g.
