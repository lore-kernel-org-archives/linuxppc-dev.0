Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tT7MY1L1PzDvM9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 15:52:57 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, dyoung@redhat.com,
 stewart@linux.vnet.ibm.com, bauerman@linux.vnet.ibm.com,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v11 0/8] powerpc: Implement kexec_file_load()
In-Reply-To: <20161129134518.7ddc9b733b65b5eed94acd3e@linux-foundation.org>
References: <1480423554-6411-1-git-send-email-mpe@ellerman.id.au>
 <20161129134518.7ddc9b733b65b5eed94acd3e@linux-foundation.org>
Date: Wed, 30 Nov 2016 15:52:56 +1100
Message-ID: <87inr5po0n.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrew Morton <akpm@linux-foundation.org> writes:

> On Tue, 29 Nov 2016 23:45:46 +1100 Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> This is v11 of the kexec_file_load() for powerpc series.
>> 
>> I've stripped this down to the minimum we need, so we can get this in for 4.10.
>> Any additions can come later incrementally.
>
> This made a bit of a mess of Mimi's series "ima: carry the
> measurement list across kexec v10".

Urk, sorry about that. I didn't realise there was a big dependency
between them, but I guess I should have tried to do the rebase.

> powerpc-ima-get-the-kexec-buffer-passed-by-the-previous-kernel.patch
> ima-on-soft-reboot-restore-the-measurement-list.patch
> ima-permit-duplicate-measurement-list-entries.patch
> ima-maintain-memory-size-needed-for-serializing-the-measurement-list.patch
> powerpc-ima-send-the-kexec-buffer-to-the-next-kernel.patch
> ima-on-soft-reboot-save-the-measurement-list.patch
> ima-store-the-builtin-custom-template-definitions-in-a-list.patch
> ima-support-restoring-multiple-template-formats.patch
> ima-define-a-canonical-binary_runtime_measurements-list-format.patch
> ima-platform-independent-hash-value.patch
>
> I made the syntactic fixes but I won't be testing it.

Thanks. 

TBH I don't know how to test the IMA part, I'm relying on Thiago and
Mimi to do that.

>> If no one objects I'll merge this via the powerpc tree. The three kexec patches
>> have been acked by Dave Young (since forever), and have been in linux-next (via
>> akpm's tree) also for a long time.
>
> OK, I'll wait for these to appear in -next and I will await advice on 

Thanks. I'll let them stew for a few more hours and then put them in my
next for tomorrows linux-next.

cheers
