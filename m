Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rl9mq5ggPzDr2n
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 05:29:30 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u66JSmqO124777
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 15:29:27 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2415xkn4v6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jul 2016 15:29:26 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 6 Jul 2016 16:29:24 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 555291DC0072
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 15:29:14 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u66JTMkH59572390
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 16:29:22 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u66JTLHG026323
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 16:29:21 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: kexec@lists.infradead.org
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, catalin.marinas@arm.com,
 will.deacon@arm.com, geoff@infradead.org, james.morse@arm.com,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v21 8/8] Documentation: dt: usable-memory and elfcorehdr
 nodes for arm64 kexec
Date: Wed, 06 Jul 2016 16:29:18 -0300
In-Reply-To: <20160706075226.27609-9-takahiro.akashi@linaro.org>
References: <20160706075226.27609-1-takahiro.akashi@linaro.org>
 <20160706075226.27609-9-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <6483018.WWW2TSJB10@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Am Mittwoch, 06 Juli 2016, 16:52:26 schrieb AKASHI Takahiro:
> +linux,usable-memory
> +-------------------
> +
> +This property is set on PowerPC and arm64 by kexec-tools during kdump
> +to tell the crash kernel the base address of its reserved area of memory,
> and +the size. e.g.
> +
> +/ {
> +	chosen {
> +		linux,usable-memory = <0x9 0xf0000000 0x0 0x10000000>;
> +	};
> +};

Again, this description is wrong for PowerPC. See messages from myself and 
Michael Ellerman:

https://lists.infradead.org/pipermail/kexec/2016-June/016250.html

https://lists.infradead.org/pipermail/kexec/2016-June/016253.html

IMHO, it would be simpler if ARM used linux,usable-memory in the same way 
that PowerPC does, for consistency.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
