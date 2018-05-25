Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40scRM2vKkzF1fl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 16:53:48 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4P6nV0U039033
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 02:53:45 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j6c8ejmrh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 02:53:45 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Fri, 25 May 2018 07:53:42 +0100
Subject: Re: [PATCH] powerpc/modules: remove unused mod_arch_specific.toc field
To: Josh Poimboeuf <jpoimboe@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <2892e4f57d03caf1b3d6c14bc456b2f9a116b32a.1527220066.git.jpoimboe@redhat.com>
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date: Fri, 25 May 2018 12:23:35 +0530
MIME-Version: 1.0
In-Reply-To: <2892e4f57d03caf1b3d6c14bc456b2f9a116b32a.1527220066.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <872c9b94-62ea-c9cc-78aa-09ae74e44d0c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 25 May 2018 09:18 AM, Josh Poimboeuf wrote:
> The toc field in the mod_arch_specific struct isn't actually used
> anywhere, so remove it.
> 
> Also the ftrace-specific fields are now common between 32-bit and
> 64-bit, so simplify the struct definition a bit by moving them out of
> the __powerpc64__ #ifdef.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
