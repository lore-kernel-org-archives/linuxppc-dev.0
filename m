Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 3ADDBB7069
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Jun 2010 22:12:04 +1000 (EST)
Message-ID: <4C20A890.9040806@redhat.com>
Date: Tue, 22 Jun 2010 15:12:00 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 1/2] KVM: PPC: Add generic hpte management functions
References: <1277127841-32704-1-git-send-email-agraf@suse.de>
	<4C20A64D.2070805@redhat.com> <4C20A6C8.4070002@suse.de>
	<4C20A795.6040607@redhat.com> <4C20A836.2010908@suse.de>
In-Reply-To: <4C20A836.2010908@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/22/2010 03:10 PM, Alexander Graf wrote:
> If you have more performance hints, I'll gladly take them :).
>    

Using a cpu that virtualizes the mmu in hardware helps tremendously.

-- 
error compiling committee.c: too many arguments to function
