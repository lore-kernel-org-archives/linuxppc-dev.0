Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199]) by ozlabs.org (Postfix) with ESMTP id 8C313B7BB6
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 07:43:25 +1100 (EST)
Received: by ywh37 with SMTP id 37so2609269ywh.17
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2009 12:43:24 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1258058202.2192.1@antares>
References: <20091112195646.GB13350@pengutronix.de> <1258058202.2192.1@antares>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 12 Nov 2009 13:43:01 -0700
Message-ID: <fa686aa40911121243i147b7962l5a249687f8e5d201@mail.gmail.com>
Subject: Re: [PATCHv2 3/3] mpc52xx/wdt: remove obsolete old WDT implementation
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>,
	Devicetree Discussions <devicetree-discuss@lists.ozlabs.org>,
	Wim Van Sebroeck <wim@iguana.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 12, 2009 at 1:36 PM, Albrecht Dre=DF <albrecht.dress@arcor.de> =
wrote:
> Hi Wolfram:
>
> Am 12.11.09 20:56 schrieb(en) Wolfram Sang:
>>
>> > Note: The file drivers/watchdog/mpc5200_wdt.c is now obsolete and shou=
ld
>> > be removed.
>>
>> Ehrm, this is possible within a patch :)
>
> Ummm, I tried that (removed the file from git locally), but apparently I'=
m
> too dumb to find the proper options to get this into the diff (to my
> defence, I'm still using cvs/svn for my projects). =A0Can you give me a h=
int?
>
>> > =A0config MPC5200_WDT
>> > - =A0 =A0 tristate "MPC5200 Watchdog Timer"
>> > + =A0 =A0 bool "MPC52xx Watchdog Timer"
>> > =A0 =A0 =A0 depends on PPC_MPC52xx
>> > + =A0 =A0 help
>> > + =A0 =A0 =A0 Use General Purpose Timer (GPT) 0 on the MPC5200 as Watc=
hdog.
>>
>> s/5200/52xx/ here too.
>
> Yes, you're right. =A0The config option should still be 'MPC5200_WDT', th=
ough,
> as otherwise all the default configs had to be touched - IMO, on the low
> level, this does no harm. =A0Thoughts?

I don't care.  Don't bother respinning just for this.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
