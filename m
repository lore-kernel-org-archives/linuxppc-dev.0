Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tS05T0PcKzDrBv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 19:21:48 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAS8Inj2087242
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 03:21:46 -0500
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 by mx0a-001b2d01.pphosted.com with ESMTP id 270f8t4qsf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 03:21:45 -0500
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 28 Nov 2016 13:51:42 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 2B5D7E0045
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 13:52:03 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAS8Lewr34996250
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 13:51:40 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAS8Lcvg017008
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 13:51:40 +0530
Date: Mon, 28 Nov 2016 13:51:36 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 "Leonidas S . Barbosa" <leosilva@linux.vnet.ibm.com>,
 linux-crypto@vger.kernel.org,
 Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] crypto: vmx - rebuild generated asm when target changes
References: <20161126042459.1964-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161126042459.1964-1-npiggin@gmail.com>
Message-Id: <20161128082136.GD29256@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/11/26 03:24PM, Nicholas Piggin wrote:
> Switching from big endian to little endian can fail to regenerate
> the crypto assembly properly. Switch to using standard form of
> kbuild dependency checking (i.e., use FORCE and if_changed).
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Hi Nick,
A similar patch is already in:
https://mid.mail-archive.com/linux-crypto@vger.kernel.org/msg21855.html

- Naveen
