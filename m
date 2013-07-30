Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 613422C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 05:59:10 +1000 (EST)
Date: Tue, 30 Jul 2013 14:58:54 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/3] mmc:core: parse voltage from device-tree
To: Zhang Haijun <B42677@freescale.com>
References: <1375066595-14968-1-git-send-email-Haijun.Zhang@freescale.com>
 <1375135638.30721.58@snotra> <51F71825.9000904@freescale.com>
In-Reply-To: <51F71825.9000904@freescale.com> (from B42677@freescale.com on
 Mon Jul 29 20:34:29 2013)
Message-ID: <1375214334.30721.82@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linux-mmc@vger.kernel.org, AFLEMING@freescale.com,
 Xie Xiaobo-R63061 <X.Xie@freescale.com>, cbouatmailru@gmail.com,
 cjb@laptop.org, linuxppc-dev@lists.ozlabs.org,
 Haijun Zhang <Haijun.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/29/2013 08:34:29 PM, Zhang Haijun wrote:
> On 07/30/2013 06:07 AM, Scott Wood wrote:
>> On 07/28/2013 09:56:33 PM, Haijun Zhang wrote:
>>> Add function to support get voltage from device-tree.
>>> If there are voltage-range specified in device-tree node, this =20
>>> function
>>> will parse it and return the avail voltage mask.
>>>=20
>>> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
>>> ---
>>>  drivers/mmc/core/core.c  | 48 =20
>>> ++++++++++++++++++++++++++++++++++++++++++++++++
>>>  include/linux/mmc/core.h |  1 +
>>>  2 files changed, 49 insertions(+)
>>=20
>> Move the code rather than copying it.
>>=20
>> -Scott
> Hi, Scott
>=20
> You mean?

The point of factoring this out is to avoid duplicating the code.  If =20
you don't remove it from the place you copied it from (and have that =20
code call here instead), then you're not avoiding the duplication.

-Scott=
