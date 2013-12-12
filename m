Return-Path: <kernelfans@gmail.com>
Received: from mail-qe0-x236.google.com (mail-qe0-x236.google.com
 [IPv6:2607:f8b0:400d:c02::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 31E1E2C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Dec 2013 13:19:17 +1100 (EST)
Received: by mail-qe0-f54.google.com with SMTP id cy11so6006686qeb.41
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 18:19:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1386755416.15730.12.camel@pasglop>
References: <1386140348-7854-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <1386140348-7854-2-git-send-email-pingfank@linux.vnet.ibm.com>
 <87a9gfva9n.fsf@linux.vnet.ibm.com>
 <CAFgQCTtd1v+ANEy899_Tk2UmYsAL1Lxe8t6WuMxFvjXk5rtn_Q@mail.gmail.com>
 <1386755416.15730.12.camel@pasglop>
Date: Thu, 12 Dec 2013 10:19:14 +0800
Message-ID: <CAFgQCTugyADVdrZYC0CDZBcjNOoi2Bt56Zt_5QwYBODGT0QaBw@mail.gmail.com>
Subject: Re: [PATCH 1/3] powerpc: mm: make _PAGE_NUMA take effect
From: Liu ping fan <kernelfans@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 11, 2013 at 5:50 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2013-12-11 at 16:50 +0800, Liu ping fan wrote:
>> > why ? , All the hash routines do check for _PAGE_PRESENT via access
>> > variable.
>> >
>> Going through __hash_page_4K(4k on 4k HW), I do not find such check.
>> Am I wrong? Or I will send out a patch to fix that.
>
> We pass a bitmask of flags to check which are tested by doing an "andc"
> of the PTE on that mask and checking if anything is left...
>
Oh, see it, thank you very much

Regards,
Pingfan
