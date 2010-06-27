Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 66F99B6EFE
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Jun 2010 20:59:23 +1000 (EST)
Message-ID: <4C272F08.8090709@redhat.com>
Date: Sun, 27 Jun 2010 13:59:20 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 08/26] KVM: PPC: Add PV guest critical sections
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-9-git-send-email-agraf@suse.de>
	<4C2709F4.10805@redhat.com>
	<77DBE095-884F-4986-BE2B-15B2EEAD8CAC@suse.de>
	<4C271F5A.1030409@redhat.com>
	<DFC77851-3BE7-4746-93DE-287D5E27EF7D@suse.de>
In-Reply-To: <DFC77851-3BE7-4746-93DE-287D5E27EF7D@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>,
	"kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/27/2010 01:33 PM, Alexander Graf wrote:
>> Or inc/dec...
>
>
> Uh - huh? How would that help?

inc shared->critical   # disable interrupts

-- 
error compiling committee.c: too many arguments to function
