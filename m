Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1BD782C00F2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 May 2013 05:09:59 +1000 (EST)
Date: Wed, 8 May 2013 14:09:45 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [v1][KVM][PATCH 1/1] kvm:ppc:booehv: direct ISI exception to Guest
To: tiejun.chen <tiejun.chen@windriver.com>
References: <1367970043.3398.39@snotra> <5189B02E.3000109@windriver.com>
In-Reply-To: <5189B02E.3000109@windriver.com> (from
 tiejun.chen@windriver.com on Tue May  7 20:53:50 2013)
Message-ID: <1368040185.3398.53@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/07/2013 08:53:50 PM, tiejun.chen wrote:
> On 05/08/2013 07:40 AM, Scott Wood wrote:
>> On 05/07/2013 06:06:30 AM, Tiejun Chen wrote:
>>> We also can direct ISI exception to Guest like DSI.
>>>=20
>>> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
>>> ---
>>>  arch/powerpc/kvm/booke_emulate.c |    3 +++
>>>  arch/powerpc/kvm/e500mc.c        |    3 ++-
>>>  2 files changed, 5 insertions(+), 1 deletion(-)
>>=20
>> Are you seeing a real performance improvement from this?  This will =20
>> interfere
>=20
> No. But after we reduce the exit to host, shouldn't this improve =20
> performance?

Not if ISIs are too rare to matter.

-Scott=
