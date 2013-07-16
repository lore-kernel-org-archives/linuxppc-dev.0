Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 82BD42C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2013 09:54:38 +1000 (EST)
Date: Tue, 16 Jul 2013 18:54:25 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V3] powerpc/85xx: Add support for 85xx cpu type detection
To: Scott Wood <scottwood@freescale.com>
References: <1373502232-4772-1-git-send-email-Haijun.Zhang@freescale.com>
 <99E897753B6F7048BD8CCDB4661D02E13C0099@039-SN2MPN1-023.039d.mgd.msft.net>
 <1373994129.8183.330@snotra>
In-Reply-To: <1373994129.8183.330@snotra> (from scottwood@freescale.com on
 Tue Jul 16 12:02:09 2013)
Message-ID: <1374018865.8183.349@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Zhao Chenhui-B35336 <B35336@freescale.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Zhang Haijun-B42677 <B42677@freescale.com>,
 Wrobel Heinz-R39252 <r39252@freescale.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>,
 "cjb@laptop.org" <cjb@laptop.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/16/2013 12:02:09 PM, Scott Wood wrote:
> On 07/16/2013 03:46:44 AM, Zhang Haijun-B42677 wrote:
>> Hi, scott
>>=20
>> Need I change something?
>> I have some patches depend on this.
>> Expect your advice.
>>=20
>> Thanks.
>>=20
>> Regards
>> Haijun.
>=20
> It looks OK; go ahead and send the patches that depend on it.

Actually, could you add p2040, p4040, p4080, p5021, and any other =20
missing ones you notice (lots of e500v2 P1/P2 chips are missing too)?

At the very least p2040 and p5021 ought to be there if you're using =20
this to check for p2041/p5040 errata, since they're basically the same =20
chip and thus have the same errata.

-Scott=
