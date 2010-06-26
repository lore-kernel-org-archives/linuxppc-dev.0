Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6ECF5B6F01
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Jun 2010 03:03:20 +1000 (EST)
In-Reply-To: <1277508314-915-25-git-send-email-agraf@suse.de>
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-25-git-send-email-agraf@suse.de>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EDF0A567-C440-4F1B-9AF5-2E0F8203D566@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 24/26] KVM: PPC: PV mtmsrd L=0 and mtmsr
Date: Sat, 26 Jun 2010 19:03:08 +0200
To: Alexander Graf <agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> There is also a form of mtmsr where all bits need to be addressed.  
> While the
> PPC64 Linux kernel behaves resonably well here, the PPC32 one never  
> uses the
> L=1 form but does mtmsr even for simple things like only changing EE.

You make it sound like the 32-bit kernel does something stupid, while
there is no other choice.  The "L=1" thing only exists for 64-bit.


Segher
