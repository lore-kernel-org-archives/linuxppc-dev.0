Return-Path: <akpm@linux-foundation.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSxst4dqPzDvtL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 08:45:06 +1100 (AEDT)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tSxst16F8z9t10
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2016 08:45:05 +1100 (AEDT)
Date: Tue, 29 Nov 2016 13:45:18 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 dyoung@redhat.com, stewart@linux.vnet.ibm.com, bauerman@linux.vnet.ibm.com,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, Thiago Jung Bauermann
 <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v11 0/8] powerpc: Implement kexec_file_load()
Message-Id: <20161129134518.7ddc9b733b65b5eed94acd3e@linux-foundation.org>
In-Reply-To: <1480423554-6411-1-git-send-email-mpe@ellerman.id.au>
References: <1480423554-6411-1-git-send-email-mpe@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 29 Nov 2016 23:45:46 +1100 Michael Ellerman <mpe@ellerman.id.au> wrote:

> This is v11 of the kexec_file_load() for powerpc series.
> 
> I've stripped this down to the minimum we need, so we can get this in for 4.10.
> Any additions can come later incrementally.

This made a bit of a mess of Mimi's series "ima: carry the
measurement list across kexec v10".

powerpc-ima-get-the-kexec-buffer-passed-by-the-previous-kernel.patch
ima-on-soft-reboot-restore-the-measurement-list.patch
ima-permit-duplicate-measurement-list-entries.patch
ima-maintain-memory-size-needed-for-serializing-the-measurement-list.patch
powerpc-ima-send-the-kexec-buffer-to-the-next-kernel.patch
ima-on-soft-reboot-save-the-measurement-list.patch
ima-store-the-builtin-custom-template-definitions-in-a-list.patch
ima-support-restoring-multiple-template-formats.patch
ima-define-a-canonical-binary_runtime_measurements-list-format.patch
ima-platform-independent-hash-value.patch

I made the syntactic fixes but I won't be testing it.

> If no one objects I'll merge this via the powerpc tree. The three kexec patches
> have been acked by Dave Young (since forever), and have been in linux-next (via
> akpm's tree) also for a long time.

OK, I'll wait for these to appear in -next and I will await advice on 
