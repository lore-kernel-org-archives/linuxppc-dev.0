Return-Path: <paolo.bonzini@gmail.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXjbH0dBkzDqjx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 19:45:15 +1000 (AEST)
Received: by mail-wm0-x243.google.com with SMTP id b187so12766546wme.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 02:45:14 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: [PATCH v2 3/3] powerpc/mm: Speed up computation of base and
 actual page size for a HPTE
To: Michael Ellerman <michael@ellerman.id.au>,
 Paul Mackerras <paulus@ozlabs.org>
References: <20160902114759.GA12433@fergus.ozlabs.ibm.com>
 <20160902115055.GC12433@fergus.ozlabs.ibm.com>
 <20160907061709.GD21443@fergus.ozlabs.ibm.com>
 <20160908100836.GA4965@fergus.ozlabs.ibm.com>
 <4ba4f3d7-eadc-5d20-534e-afc7075938fc@redhat.com>
 <877fahrf8w.fsf@concordia.ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <51956245-1b7f-c2b5-5a21-d87d9113f9eb@redhat.com>
Date: Mon, 12 Sep 2016 11:45:08 +0200
MIME-Version: 1.0
In-Reply-To: <877fahrf8w.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 12/09/2016 05:03, Michael Ellerman wrote:
>> > Can you place it in a pull request for both Michael and myself?
> Paul and I talked about this offline, he's going to create a topic
> branch with this in it.
> 
> I'll hold off merging it until closer to the merge window, and I'll
> merge it then if we are actually seeing conflicts between the PPC & KVM
> trees caused by this.

Sounds like best of both worlds.  Thanks!

Paolo
