Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTKhP2fCTzDqH1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 14:38:29 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1N3Yrjg050641
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 22:38:27 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28sp4hky1d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 22:38:26 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 22 Feb 2017 20:38:26 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Rashmica Gupta <rashmica.g@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 npiggin@gmail.com, bsingharora@gmail.com, dllehr@us.ibm.com,
 mpe@ellerman.id.au
Cc: Rashmica Gupta <rashmica.g@gmail.com>
Subject: Re: [RFC] Remove memory from nodes for memtrace.
In-Reply-To: <20170222213910.5628-1-rashmica.g@gmail.com>
References: <20170222213910.5628-1-rashmica.g@gmail.com>
Date: Thu, 23 Feb 2017 14:38:17 +1100
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8760k1fufq.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rashmica Gupta <rashmica.g@gmail.com> writes:
> +}
> +machine_device_initcall(powernv, memtrace_init);
> +
> +
> +
> +/* XXX FIXME DEBUG CRAP */
> +machine_device_initcall(pseries, memtrace_init);

Should the fixme be there?

-- 
Stewart Smith
OPAL Architect, IBM.
