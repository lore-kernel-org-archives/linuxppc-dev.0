Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E187FB7BC6
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Nov 2009 22:35:42 +1100 (EST)
Subject: Re: [PATCH 14/27] Add book3s_64 specific opcode emulation
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1257324441.13611.55.camel@pasglop>
Date: Wed, 4 Nov 2009 12:35:29 +0100
Message-Id: <A9E9F4C0-3AC8-4A50-AE9E-9C96126C24BC@suse.de>
References: <1256917647-6200-1-git-send-email-agraf@suse.de>
	<280C9FF6-1C52-4856-9F60-15DA0659FC31@suse.de>
	<1257284313.7907.80.camel@pasglop>
	<200911040943.46617.arnd@arndb.de>
	<1257324441.13611.55.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Hollis Blanchard <hollisb@us.ibm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm-ppc <kvm-ppc@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>, Avi Kivity <avi@redhat.com>,
	kvm@vger.kernel.org, bphilips@suse.de, Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 04.11.2009, at 09:47, Benjamin Herrenschmidt wrote:

> On Wed, 2009-11-04 at 09:43 +0100, Arnd Bergmann wrote:
>> On Tuesday 03 November 2009, Benjamin Herrenschmidt wrote:
>>> (Though glibc can be nasty, afaik it might load up optimized
>> variants of
>>> some routines with hard wired cache line sizes based on the CPU
>> type)
>>
>> You can also get application with hand-coded cache optimizations
>> that are even harder, if not impossible, to fix.
>
> Right. But those are already broken across CPU variants anyways.

... which might be the reason you're using KVM in the first place.

Alex
