Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C20261007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  4 Jul 2010 19:04:36 +1000 (EST)
Subject: Re: [PATCH 27/27] KVM: PPC: Add Documentation about PV interface
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1278196956.4200.390.camel@pasglop>
Date: Sun, 4 Jul 2010 11:04:30 +0200
Message-Id: <A038C08C-C69F-4E34-884A-A31AD4A9D9D5@suse.de>
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
	<1277980982-12433-28-git-send-email-agraf@suse.de>
	<EB2E1C5B-118B-481B-83D6-44CFAA2E55D3@kernel.crashing.org>
	<A98DA9FC-DC42-452E-BD44-5F86D1707BF0@suse.de>
	<1278196956.4200.390.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 04.07.2010, at 00:42, Benjamin Herrenschmidt wrote:

> On Fri, 2010-07-02 at 20:41 +0200, Alexander Graf wrote:
>> The u64s are 64-bit aligned, should they always be?
>> 
>> That's obvious, isn't it? And the ABI only specifies u64s to be 32 bit
>> aligned, no? At least that's what ld and std specify.
> 
> No, the PowerPC ABI specifies u64's to be 64-bit aligned, even for
> 32-bit binaries.

I see :).

Alex
