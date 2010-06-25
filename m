Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) by ozlabs.org (Postfix) with ESMTP id 9CB281007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Jun 2010 09:05:16 +1000 (EST)
Received: by iwn5 with SMTP id 5so1349349iwn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Jun 2010 16:05:14 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100622230026.GA2453@opensource.wolfsonmicro.com>
References: <1276617907-10862-1-git-send-email-emillbrandt@dekaresearch.com>
	<20100622230026.GA2453@opensource.wolfsonmicro.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 25 Jun 2010 17:04:54 -0600
Message-ID: <AANLkTiluyeGSwVSXgTeRxS3hVWTe3Gkn8qHrqbHJFMun@mail.gmail.com>
Subject: Re: [PATCH 0/2 v3] mpc5200 ac97 gpio reset
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org,
	Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 22, 2010 at 5:00 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Jun 15, 2010 at 12:05:05PM -0400, Eric Millbrandt wrote:
>> These patches reimplement the reset fuction in the ac97 to use gpio pins
>> instead of using the mpc5200 ac97 reset functionality in the psc. =A0Thi=
s
>> avoids a problem in which attached ac97 devices go into "test" mode appe=
ar
>> unresponsive.
>>
>> These patches were tested on a pcm030 baseboard and on custom hardware w=
ith
>> a wm9715 audio codec/touchscreen controller.
>
> Grant, are you OK with this series?

Yes, I'm going to pick it up.

g.
