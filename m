Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 43D572C0089
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2012 05:39:55 +1000 (EST)
Subject: Re: [PATCH] KVM: PPC: BookE: HV: Fix compile
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <9849.1343262707@neuling.org>
Date: Thu, 6 Sep 2012 15:39:44 -0400
Message-Id: <818FBC6A-DF77-4DD6-9127-0C151656002B@suse.de>
References: <1343170954-9460-1-git-send-email-agraf@suse.de>
 <9849.1343262707@neuling.org>
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, KVM list <kvm@vger.kernel.org>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 25.07.2012, at 20:31, Michael Neuling wrote:

> Alexander Graf <agraf@suse.de> wrote:
>=20
>> After merging the register type check patches from Ben's tree, the
>> hv enabled booke implementation ceased to compile.
>>=20
>> This patch fixes things up so everyone's happy again.
>=20
> Is there a defconfig which catches this?

Hrm. I don't think a defconfig gets you there, as KVM isn't enabled by =
default. Just configure your kernel with support for e500mc and enable =
KVM :).


Alex
