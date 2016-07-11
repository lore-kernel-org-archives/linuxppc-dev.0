Return-Path: <dyoung@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rnqC34lVLzDqpW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 12:42:55 +1000 (AEST)
Date: Mon, 11 Jul 2016 10:42:47 +0800
From: Dave Young <dyoung@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v4 3/9] kexec_file: Factor out kexec_locate_mem_hole from
 kexec_add_buffer.
Message-ID: <20160711024247.GA2853@dhcp-128-65.nay.redhat.com>
References: <1467908615-18952-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1467908615-18952-4-git-send-email-bauerman@linux.vnet.ibm.com>
 <87a8hqja39.fsf@@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87a8hqja39.fsf@@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/10/16 at 04:11pm, Michael Ellerman wrote:
> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
> 
> > kexec_locate_mem_hole will be used by the PowerPC kexec_file_load
> > implementation to find free memory for the purgatory stack.
> >
> > Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> > Cc: Eric Biederman <ebiederm@xmission.com>
> > Cc: Dave Young <dyoung@redhat.com>
> 
> Dave are you happy with the first three patches? If so do you mind
> sending an ack?

I reviewed the 3 patches, they look good to me. Will ack after a small test today.

> 
> Given the series touches generic code, x86 and powerpc this might be one
> for Andrew to take. Or is there a kexec tree it should go through?

They should go Andrew's tree, but I'm not sure about the powerpc part.

Thanks
Dave
