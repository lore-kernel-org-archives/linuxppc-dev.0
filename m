Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 43A472C00B5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 22:48:06 +1100 (EST)
Subject: Re: [PATCH] KVM: PPC: e500: Add separate functions for vcpu's MMU
 configuration
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <300B73AA675FCE4A93EB4FC1D42459FF373151@039-SN2MPN1-012.039d.mgd.msft.net>
Date: Thu, 21 Mar 2013 12:48:00 +0100
Message-Id: <D7150729-8081-43AF-ADEF-2F6349D52C31@suse.de>
References: <1363713407-27886-1-git-send-email-mihai.caraman@freescale.com>
 <90E4FFA9-97C8-4D7D-910E-2E5DB273C88C@suse.de>
 <300B73AA675FCE4A93EB4FC1D42459FF373151@039-SN2MPN1-012.039d.mgd.msft.net>
To: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 21.03.2013, at 12:19, Caraman Mihai Claudiu-B02008 wrote:

>> -----Original Message-----
>> From: kvm-ppc-owner@vger.kernel.org [mailto:kvm-ppc-
>> owner@vger.kernel.org] On Behalf Of Alexander Graf
>> Sent: Thursday, March 21, 2013 12:07 PM
>> To: Caraman Mihai Claudiu-B02008
>> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
>> dev@lists.ozlabs.org
>> Subject: Re: [PATCH] KVM: PPC: e500: Add separate functions for =
vcpu's
>> MMU configuration
>>=20
>>=20
>> On 19.03.2013, at 18:16, Mihai Caraman wrote:
>>=20
>>> Move vcpu's MMU default configuration and geometry update into their
>> own
>>> functions.
>>=20
>> Mind to explain why?
>=20
> You requested a separate function for clearing TLBnCFG_IND bit (E.PT =
removal)
> to self-document the code. The existing logic (that TLBnCFG_IND relies =
on)
> was buried in a chunk of code and I thought this will add more =
clarity.
> If you don't agree I would document the code at least.

I guess I'll have to see the full picture then. Please just include this =
patch in the series when you change the IND bit and make the patch =
description a bit more obvious: Just indicate that you need this a =
cleanup to make the IND patch more readable.


Alex
