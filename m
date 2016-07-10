Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rnHtl6m9WzDqpG
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jul 2016 16:11:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Dave Young  <dyoung@redhat.com>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v4 3/9] kexec_file: Factor out kexec_locate_mem_hole from
 kexec_add_buffer.
In-Reply-To: <1467908615-18952-4-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1467908615-18952-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1467908615-18952-4-git-send-email-bauerman@linux.vnet.ibm.com>
Date: Sun, 10 Jul 2016 16:11:54 +1000
Message-ID: <87a8hqja39.fsf@@concordia.ellerman.id.au>
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

Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:

> kexec_locate_mem_hole will be used by the PowerPC kexec_file_load
> implementation to find free memory for the purgatory stack.
>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Dave Young <dyoung@redhat.com>

Dave are you happy with the first three patches? If so do you mind
sending an ack?

Given the series touches generic code, x86 and powerpc this might be one
for Andrew to take. Or is there a kexec tree it should go through?

cheers
