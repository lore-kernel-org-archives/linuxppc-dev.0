Return-Path: <chris@distroguy.com>
Received: from mx-out03.mykolab.com (mx01.mykolab.com [95.128.36.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTCKp0MlMzDqgM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 11:51:09 +1000 (AEST)
Received: from mx03.mykolab.com (mx03.mykolab.com [10.20.7.101])
 by mx-out03.mykolab.com (Postfix) with ESMTPS id B6F1120896
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 03:51:03 +0200 (CEST)
Date: Tue, 14 Jun 2016 11:50:57 +1000
From: Chris Smart <chris@distroguy.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc: Send SIGBUS on unaligned copy and paste
Message-ID: <20160614015056.GA29205@distroguy.com>
References: <20160609060120.GA26093@distroguy.com>
 <edaf7a67-10c9-1e18-e416-38f45e4a5192@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
In-Reply-To: <edaf7a67-10c9-1e18-e416-38f45e4a5192@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 09, 2016 at 08:57:50AM +0200, Christophe Leroy wrote:
>
>Le 09/06/2016 à 08:01, Chris Smart a écrit :
>>Calling ISA 3.0 instructions copy, copy_first, paste and paste_last
>>generates an alignment fault when copying or pasting unaligned
>>data (128 byte). We catch this and send SIGBUS to the userspace
>>process that caused it.
>>

[snip]

>>+    if ((instruction & 0xfc0006fe) == 0x7c00060c){
>
>Can you define corresponding instruction and mask in 
>arch/powerpc/include/asm/ppc-opcode.h
>and use symbolic names here instead of raw values ?
>

Yep, thanks. Will look at doing this for V2.

Cheers,
-c
