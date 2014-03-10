Return-Path: <pbonzini@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 6BBEF2C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Mar 2014 21:51:48 +1100 (EST)
Message-ID: <531D9937.5010705@redhat.com>
Date: Mon, 10 Mar 2014 11:51:35 +0100
From: Paolo Bonzini <pbonzini@redhat.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] Revert "KVM: PPC: Book3S HV: Add new state for
 transactional memory"
References: <1394102170-22126-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20140310105028.GA5934@iris.ozlabs.ibm.com>
In-Reply-To: <20140310105028.GA5934@iris.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Il 10/03/2014 11:50, Paul Mackerras ha scritto:
> We can either do this revert, or apply a patch removing the extra
> hunk, but one or the other should go in for 3.14 since it's quite
> broken as it is (that is, HV-mode KVM on powerpc is broken).
>
> Paolo, do you have a preference about revert vs. fix?  Are you happy
> to take what Aneesh sent (in which case please add my acked-by and
> perhaps edit the commentary to say how the problem arose), or do you
> want a freshly-prepared patch, and if so against which branch?

I prefer a fix.

Paolo
