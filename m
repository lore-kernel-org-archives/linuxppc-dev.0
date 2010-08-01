Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179]) by ozlabs.org (Postfix) with ESMTP id 13DB11007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  1 Aug 2010 14:42:38 +1000 (EST)
Received: by yxm8 with SMTP id 8so1081239yxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 31 Jul 2010 21:42:35 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <D37786F8-EBA7-4E55-AE83-5D0ABF1E17BF@opensource.wolfsonmicro.com>
References: <1276617907-10862-1-git-send-email-emillbrandt@dekaresearch.com>
	<20100622230026.GA2453@opensource.wolfsonmicro.com>
	<AANLkTiluyeGSwVSXgTeRxS3hVWTe3Gkn8qHrqbHJFMun@mail.gmail.com>
	<D37786F8-EBA7-4E55-AE83-5D0ABF1E17BF@opensource.wolfsonmicro.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 31 Jul 2010 22:42:15 -0600
Message-ID: <AANLkTikbHp18uc-idFtEqakoo_0Vdg_rU44xv9uHwkvG@mail.gmail.com>
Subject: Re: [PATCH 0/2 v3] mpc5200 ac97 gpio reset
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 27, 2010 at 4:01 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
>
> On 26 Jun 2010, at 00:04, Grant Likely <grant.likely@secretlab.ca> wrote:
>
>> On Tue, Jun 22, 2010 at 5:00 PM, Mark Brown
>>> On Tue, Jun 15, 2010 at 12:05:05PM -0400, Eric Millbrandt wrote:
>>>> These patches reimplement the reset fuction in the ac97 to use gpio pi=
ns
>>>> instead of using the mpc5200 ac97 reset functionality in the psc. =A0T=
his
>>>> avoids a problem in which attached ac97 devices go into "test" mode ap=
pear
>>>> unresponsive.
>>>>
>>>> These patches were tested on a pcm030 baseboard and on custom hardware=
 with
>>>> a wm9715 audio codec/touchscreen controller.
>>>
>>> Grant, are you OK with this series?
>>
>> Yes, I'm going to pick it up.
>
> I'm a little concerned with a collision with multi codec here. It'd
> be handy if you could keep it separate in case it needs merging
> into both trees (or we could merge via ASoC only).

Hmmm.  Yeah, probably better to take it via your tree then.  I've
currently got patch 1 in linux-next, but I'll drop it before asking
benh to pull.  Go ahead and add my acked-by.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
