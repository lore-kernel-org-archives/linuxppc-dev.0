Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f172.google.com (mail-gx0-f172.google.com
	[209.85.217.172]) by ozlabs.org (Postfix) with ESMTP id E1BABDDF82
	for <linuxppc-dev@ozlabs.org>; Sat,  9 May 2009 01:53:42 +1000 (EST)
Received: by gxk20 with SMTP id 20so2997251gxk.9
	for <linuxppc-dev@ozlabs.org>; Fri, 08 May 2009 08:53:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4b73d43f0905071941xaa78e4dj41f7396ff227af31@mail.gmail.com>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-11-git-send-email-wd@denx.de>
	<20090506210644.GA17311@pengutronix.de>
	<fa686aa40905061540x96c1524hd88ee78bc366b89b@mail.gmail.com>
	<4b73d43f0905071941xaa78e4dj41f7396ff227af31@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 8 May 2009 09:53:20 -0600
Message-ID: <fa686aa40905080853q2156ba46w3d56d0285271ce43@mail.gmail.com>
Subject: Re: [rtc-linux] Re: [PATCH 10/12] mpc5121: Add MPC5121 Real time
	clock driver.
To: John Rigby <jcrigby@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Piotr Ziecik <kosmo@semihalf.com>,
	rtc-linux@googlegroups.com, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 7, 2009 at 8:41 PM, John Rigby <jcrigby@gmail.com> wrote:
> Can we get 5121 support in and add 5200 support later?=A0 They are not
> identical.

That is fine by me, but since it is known that it will eventually
support both, I'd like it to be renamed to 5xxx before it is merged to
avoid a later rename patch.

g.

> On Wed, May 6, 2009 at 4:40 PM, Grant Likely <grant.likely@secretlab.ca>
> wrote:
>>
>> On Wed, May 6, 2009 at 3:06 PM, Wolfram Sang <w.sang@pengutronix.de>
>> wrote:
>> > On Wed, May 06, 2009 at 10:15:17PM +0200, Wolfgang Denk wrote:
>> >> From: John Rigby <jrigby@freescale.com>
>> >>
>> >> Based on Domen Puncer's rtc driver for 5200 posted to
>> >> the ppclinux mailing list:
>> >> =A0 =A0 =A0 http://patchwork.ozlabs.org/linuxppc-embedded/patch?id=3D=
11675
>> >> but never commited anywhere.
>> >>
>> >> Changes to Domen's original:
>> >>
>> >> =A0 =A0 Changed filenames/routine names from mpc5200* to mpc5121*
>> >
>> > Why not changing it to mpc5xxx? From a glimpse, it should still work o=
n
>> > MPC5200, too.
>>
>> If this is true, the I heartily agree with Wolfram. =A0:-)
>>
>> g.
>>
>> --
>> Grant Likely, B.Sc., P.Eng.
>> Secret Lab Technologies Ltd.
>>
>> --~--~---------~--~----~------------~-------~--~----~
>> You received this message because you are subscribed to "rtc-linux".
>> Membership options at http://groups.google.com/group/rtc-linux .
>> Please read http://groups.google.com/group/rtc-linux/web/checklist
>> before submitting a driver.
>> -~----------~----~----~----~------~----~------~--~---
>>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
