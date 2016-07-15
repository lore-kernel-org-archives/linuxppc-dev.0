Return-Path: <vgoyal@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrXwk1jyVzDqF6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 23:09:58 +1000 (AEST)
Date: Fri, 15 Jul 2016 09:09:55 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: ebiederm@xmission.com, dyoung@redhat.com, bhe@redhat.com,
 bauerman@linux.vnet.ibm.com, arnd@arndb.de, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC 3/3] kexec: extend kexec_file_load system call
Message-ID: <20160715130955.GC23514@redhat.com>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <20160712014201.11456-4-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160712014201.11456-4-takahiro.akashi@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 12, 2016 at 10:42:01AM +0900, AKASHI Takahiro wrote:

[..]
> -SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> +SYSCALL_DEFINE6(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  		unsigned long, cmdline_len, const char __user *, cmdline_ptr,
> -		unsigned long, flags)
> +		unsigned long, flags, const struct kexec_fdset __user *, ufdset)

Can one add more parameters to existing syscall. Can it break existing
programs with new kernel? I was of the impression that one can't do that.
But may be I am missing something.

Vivek
