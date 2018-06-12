Return-Path: <fweimer@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414pmQ6yd1zF4Tq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 22:17:26 +1000 (AEST)
Subject: Re: pkeys on POWER: Access rights not reset on execve
To: Ram Pai <linuxram@us.ibm.com>
Cc: Linux-MM <linux-mm@kvack.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>
References: <20180603201832.GA10109@ram.oc3035372033.ibm.com>
 <4e53b91f-80a7-816a-3e9b-56d7be7cd092@redhat.com>
 <20180604140135.GA10088@ram.oc3035372033.ibm.com>
 <f2f61c24-8e8f-0d36-4e22-196a2a3f7ca7@redhat.com>
 <20180604190229.GB10088@ram.oc3035372033.ibm.com>
 <30040030-1aa2-623b-beec-dd1ceb3eb9a7@redhat.com>
 <20180608023441.GA5573@ram.oc3035372033.ibm.com>
 <2858a8eb-c9b5-42ce-5cfc-74a4b3ad6aa9@redhat.com>
 <20180611172305.GB5697@ram.oc3035372033.ibm.com>
 <30f5cb0e-e09a-15e6-f77d-a3afa422a651@redhat.com>
 <20180611200807.GA5773@ram.oc3035372033.ibm.com>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <c2931344-d2e8-46c0-b70c-97567ae7f7a0@redhat.com>
Date: Tue, 12 Jun 2018 14:17:21 +0200
MIME-Version: 1.0
In-Reply-To: <20180611200807.GA5773@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/11/2018 10:08 PM, Ram Pai wrote:
> Ok. try this patch. This patch is on top of the 5 patches that I had
> sent last week i.e  "[PATCH  0/5] powerpc/pkeys: fixes to pkeys"
> 
> The following is a draft patch though to check if it meets your
> expectations.
> 
> commit fe53b5fe2dcb3139ea27ade3ae7cbbe43c4af3be
> Author: Ram Pai<linuxram@us.ibm.com>
> Date:   Mon Jun 11 14:57:34 2018 -0500
> 
>      powerpc/pkeys: Deny read/write/execute by default

With this patch, my existing misc/tst-pkey test in glibc passes.  The 
in-tree version still has some incorrect assumptions on implementation 
behavior, but those are test bugs.  The kernel behavior with your patch 
look good to me.  Thanks.

Florian
