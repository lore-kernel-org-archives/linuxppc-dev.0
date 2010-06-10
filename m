Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) by ozlabs.org (Postfix) with ESMTP id CAFA8B7D98
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Jun 2010 09:31:35 +1000 (EST)
Received: by gyd10 with SMTP id 10so385473gyd.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Jun 2010 16:31:34 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <333E09B4-32C5-483A-9C1F-A1206AF937B0@opensource.wolfsonmicro.com>
References: <1276015562-28928-1-git-send-email-emillbrandt@dekaresearch.com>
	<AANLkTimIs90kR5uqhdBQ02oSd94dn08sOITm51Ylrl4-@mail.gmail.com>
	<20100609061330.620AC14E867@gemini.denx.de>
	<20100609103046.GC5618@opensource.wolfsonmicro.com>
	<AANLkTinascmPq38PptPH3tRJS-P8IqO9tdLbVb5erLRY@mail.gmail.com>
	<333E09B4-32C5-483A-9C1F-A1206AF937B0@opensource.wolfsonmicro.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 10 Jun 2010 17:31:12 -0600
Message-ID: <AANLkTinZyP40DPc3SeNq8xx3OwUaLil6vMC2w07lQSvU@mail.gmail.com>
Subject: Re: [PATCH 0/2] mpc5200 ac97 gpio reset
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Wolfgang Denk <wd@denx.de>,
	Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 10, 2010 at 5:14 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On 10 Jun 2010, at 23:07, Grant Likely wrote:
>
>> To me, this seems firmly in the realm of silicon bug workaround.
>> Considering that the pins aren't relocatable (ie, the GPIO numbers
>> never change), I've got no problem having the GPIO reset logic added
>> to arch/powerpc/platforms/52xx and hard coding the GPIO numbers.
>
> Since the pins are fixed I agree - I was assuming that the DT updates
> were there because there were multiple pin mux options for the AC'97
> controller so we needed the DT to say which were in use on the board.

:-)  I originally also made the same assumption, until I actually went
and looked at the data sheet.

g.
