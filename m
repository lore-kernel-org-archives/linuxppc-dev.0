Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJMtG1zDvzDt0c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 09:45:42 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAFMcrf6085377
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 17:45:39 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26r2ch0msf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 17:45:38 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 16 Nov 2016 08:45:36 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9437E2BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 09:45:34 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAFMjYXa30212136
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 09:45:34 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAFMjXDP032602
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 09:45:34 +1100
Subject: Re: [kernel-hardening] [PATCH] powerpc/kernel: Disable the latent
 entropy plugin unconditionally
To: Kees Cook <keescook@chromium.org>
References: <20160626173451.c8406cd0c7a87cc3f94d9753@gmail.com>
 <70eb7a4c-be31-3fdd-a5b4-8075b29b3b38@au1.ibm.com>
 <CAGXu5j+8=3Vxm52Y2QbkDiCPx5X6DWemPO7B=2kj2EdVQpLHpA@mail.gmail.com>
Cc: "kernel-hardening@lists.openwall.com"
 <kernel-hardening@lists.openwall.com>, Michal Marek <mmarek@suse.com>,
 linux-kbuild <linux-kbuild@vger.kernel.org>, PaX Team
 <pageexec@freemail.hu>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 16 Nov 2016 09:45:31 +1100
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+8=3Vxm52Y2QbkDiCPx5X6DWemPO7B=2kj2EdVQpLHpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <f1e8522c-b33a-77ce-c2c3-9c74a468e663@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 16/11/16 09:41, Kees Cook wrote:
> Just checking in: did these patches materialize? I'd love to see
> plugins working on v4.10 for ppc.

Working on it! 
https://github.com/ajdlinux/linux/tree/powerpc-gcc-plugin-infrastructure

Just need to test with all the compilers to figure out which ones are 
broken so we can put a version check in...

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
