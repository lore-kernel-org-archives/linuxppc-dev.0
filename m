Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v6dGy14WnzDqJ1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 04:15:05 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0NH3oRu057912
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jan 2017 12:15:03 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0a-001b2d01.pphosted.com with ESMTP id 285cwx8sr7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jan 2017 12:15:02 -0500
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 23 Jan 2017 22:44:57 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id E56B8394004E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jan 2017 22:44:55 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0NHEtM629753548
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jan 2017 22:44:55 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0NHEsSa029542
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jan 2017 22:44:55 +0530
Date: Mon, 23 Jan 2017 22:44:53 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: David Miller <davem@davemloft.net>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 ast@fb.com, daniel@iogearbox.net
Subject: Re: [PATCH 1/3] powerpc: bpf: remove redundant check for non-null
 image
References: <e73efe6facf6c06932b4a87707e5978172ee773e.1484326337.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170116.133859.1157069434816521683.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170116.133859.1157069434816521683.davem@davemloft.net>
Message-Id: <20170123171453.GD3820@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi David,

On 2017/01/16 01:38PM, David Miller wrote:
> 
> I'm assuming these patches will go via the powerpc tree.
> 
> If you want them to go into net-next, I kindly ask that you always
> explicitly say so, and furthermore always submit a patch series with
> a proper "[PATCH 0/N] ..." header posting.

Sure. Sorry for the confusion. I will be more explicit next time.

Thanks,
Naveen
