Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 1DAEDB6EE9
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jun 2011 18:35:00 +1000 (EST)
Message-ID: <4E0C352D.60008@redhat.com>
Date: Thu, 30 Jun 2011 11:34:53 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 17/17] KVM: PPC: Add an ioctl for userspace to select
	which platform to emulate
References: <20110629101552.GA25406@bloggs.ozlabs.ibm.com>
	<20110629104103.GR25406@bloggs.ozlabs.ibm.com>
	<20110629115346.GA17551@zod.rchland.ibm.com>
	<B21FDD77-90CF-4A23-84E3-8C73CFF70B92@suse.de>
	<20110629115857.GB17551@zod.rchland.ibm.com>
In-Reply-To: <20110629115857.GB17551@zod.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Alexander Graf <agraf@suse.de>, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/29/2011 02:58 PM, Josh Boyer wrote:
> >>  This makes me wonder if a similar thing might eventually be usable for
> >>  running an i686 or x32 guest on an x86_64 KVM host.  I have no idea if
> >>  that is even theoretically possible, but if it is it might be better to
> >>  rename the ioctl to be architecture agnostic.
> >
> >On x86 this is not required unless we want to "virtualize" pre-CPUID CPUs. Everything as of Pentium has a full bitmap of feature capabilities that KVM gets from user space, including information such as "Can we do 64-bit mode?".
>
> Ah.  Thank you for the explanation.

To clarify a bit further, running an i686 guest on an x86_64 host is not 
only theoretically possible, but is done regularly.  First, x86_64 is 
backwards compatible with i686 (so you can install a 32-bit OS on 64-bit 
hardware), and second, you can impersonate 32-bit guest hardware on a 
64-bit host.

-- 
error compiling committee.c: too many arguments to function
