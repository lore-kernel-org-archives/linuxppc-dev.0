Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-oi0-x232.google.com (mail-oi0-x232.google.com
 [IPv6:2607:f8b0:4003:c06::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40cnNR4HnmzDqhm
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 19:51:50 +1000 (AEST)
Received: by mail-oi0-x232.google.com with SMTP id 11-v6so18603967ois.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 May 2018 02:51:50 -0700 (PDT)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 4 May 2018 11:51:27 +0200
Message-ID: <CA+7wUsxwRi3tLRR_+-=h_y2Xj_RfJS58E0vpa8K1KPtRAQpr_g@mail.gmail.com>
Subject: seccomp_bpf.c:2880:global.get_metadata:Expected 0 (0) == seccomp(1,
 2, &prog) (4294967295)
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi there,

Quick question (I have not investigate root cause): is support for
seccomp complete on ppc32 ?

$ make KBUILD_OUTPUT=/tmp/kselftest TARGETS=seccomp kselftest
...
seccomp_bpf.c:1804:TRACE_syscall.ptrace_syscall_dropped:Expected 1 (1)
== syscall(286) (4294967295)
TRACE_syscall.ptrace_syscall_dropped: Test failed at step #13
[     FAIL ] TRACE_syscall.ptrace_syscall_dropped
...
[ RUN      ] global.get_metadata
seccomp_bpf.c:2880:global.get_metadata:Expected 0 (0) == seccomp(1, 2,
&prog) (4294967295)
seccomp_bpf.c:2892:global.get_metadata:Expected 1 (1) ==
read(pipefd[0], &buf, 1) (0)
global.get_metadata: Test terminated by assertion
[     FAIL ] global.get_metadata


Thanks
