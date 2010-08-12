Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id 06BB0B70B8
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Aug 2010 14:21:56 +1000 (EST)
Received: by gwj15 with SMTP id 15so481592gwj.15
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Aug 2010 21:21:55 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <3850A844E6A3854C827AC5C0BEC7B60A0565B8@zch01exm23.fsl.freescale.net>
References: <3850A844E6A3854C827AC5C0BEC7B60A0565B8@zch01exm23.fsl.freescale.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 11 Aug 2010 22:21:35 -0600
Message-ID: <AANLkTinMs+brv22ES5aMvVNi=bYEVY13eJwbJCyF5o2-@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: change ACMD12 to AUTO_CMD12 for more clear
To: Zang Roy-R61911 <r61911@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@ozlabs.org, mirqus@gmail.com,
	akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 11, 2010 at 10:00 PM, Zang Roy-R61911 <r61911@freescale.com> wr=
ote:
>
>
>> -----Original Message-----
>> From: Zang Roy-R61911
>> Sent: Wednesday, August 11, 2010 12:47 PM
>> To: Zang Roy-R61911; akpm@linux-foundation.org;
>> linux-mmc@vger.kernel.org
>> Cc: linuxppc-dev@ozlabs.org; mirqus@gmail.com;
>> cbouatmailru@gmail.com; grant.likely@secretlab.ca
>> Subject: RE: [PATCH 1/2] mmc: change ACMD12 to AUTO_CMD12 for
>> more clear
>>
>>
>>
>> > -----Original Message-----
>> > From: Zang Roy-R61911
>> > Sent: Tuesday, August 10, 2010 17:47 PM
>> > To: akpm@linux-foundation.org; linux-mmc@vger.kernel.org
>> > Cc: linuxppc-dev@ozlabs.org; mirqus@gmail.com;
>> > cbouatmailru@gmail.com; grant.likely@secretlab.ca
>> > Subject: [PATCH 1/2] mmc: change ACMD12 to AUTO_CMD12 for more clear
>> >
>> > Change ACMD12 to AUTO_CMD12 to reduce the confusion.
>> > ACMD12 might be confused with MMC/SD App CMD 12 (CMD55+CMD12 combo).
>> >
>> > Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
>> > ---
>> > =A0drivers/mmc/host/sdhci-of-core.c | =A0 =A02 +-
>> > =A0drivers/mmc/host/sdhci.c =A0 =A0 =A0 =A0 | =A0 =A08 ++++----
>> > =A0drivers/mmc/host/sdhci.h =A0 =A0 =A0 =A0 | =A0 10 +++++-----
>> > =A03 files changed, 10 insertions(+), 10 deletions(-)
>> Andrew,
>> Could you help to pick up this minor fix?
>> Thanks.
>> Roy
> Any update?
> Thanks.
> Roy

Patience Roy.  You only sent the patch 1 day ago.

g.
