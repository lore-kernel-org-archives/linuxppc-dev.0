Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gMSH1FBVzDrnp
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 00:34:07 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Malaterre <malat@debian.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: seccomp_bpf.c:2880:global.get_metadata:Expected 0 (0) ==
 seccomp(1, 2, &prog) (4294967295)
In-Reply-To: <CA+7wUsxwRi3tLRR_+-=h_y2Xj_RfJS58E0vpa8K1KPtRAQpr_g@mail.gmail.com>
References: <CA+7wUsxwRi3tLRR_+-=h_y2Xj_RfJS58E0vpa8K1KPtRAQpr_g@mail.gmail.com>
Date: Wed, 09 May 2018 00:34:03 +1000
Message-ID: <874lji1ajo.fsf@concordia.ellerman.id.au>
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

Mathieu Malaterre <malat@debian.org> writes:

> Hi there,
>
> Quick question (I have not investigate root cause): is support for
> seccomp complete on ppc32 ?

Doesn't look like it does it :)

> $ make KBUILD_OUTPUT=/tmp/kselftest TARGETS=seccomp kselftest
> ...
> seccomp_bpf.c:1804:TRACE_syscall.ptrace_syscall_dropped:Expected 1 (1)
> == syscall(286) (4294967295)
> TRACE_syscall.ptrace_syscall_dropped: Test failed at step #13
> [     FAIL ] TRACE_syscall.ptrace_syscall_dropped
> ...
> [ RUN      ] global.get_metadata
> seccomp_bpf.c:2880:global.get_metadata:Expected 0 (0) == seccomp(1, 2,
> &prog) (4294967295)
> seccomp_bpf.c:2892:global.get_metadata:Expected 1 (1) ==
> read(pipefd[0], &buf, 1) (0)
> global.get_metadata: Test terminated by assertion
> [     FAIL ] global.get_metadata

I'm not sure sorry.

That could be a test case bug, hard to say without looking at the
details.

cheers
