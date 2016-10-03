Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3snmZ80CgfzDrDv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 02:44:31 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u93FhPKO018337
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Oct 2016 11:44:29 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25usushh86-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Oct 2016 11:44:28 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Mon, 3 Oct 2016 12:44:27 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 9E99C3520068
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Oct 2016 11:43:58 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u93FiNFF4862092
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Oct 2016 12:44:23 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u93FiNFl002376
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Oct 2016 12:44:23 -0300
Subject: Re: powerpc: add kernel parameter iommu_alloc_quiet
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <3sfLdY1WwLz9syB@ozlabs.org>
 <d5a4d7c5-a700-b990-620d-132f09d69be0@linux.vnet.ibm.com>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Mon, 3 Oct 2016 12:44:20 -0300
MIME-Version: 1.0
In-Reply-To: <d5a4d7c5-a700-b990-620d-132f09d69be0@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <89667da2-b325-456c-0b2c-567e9d904808@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On 09/21/2016 11:34 AM, Mauricio Faria de Oliveira wrote:
> So, the intent is to have a single/common hack that upstream is OK w/,
> then apply that downstream in the multiple distros.  Of course, if you
> are not OK w/ this patch (which is obviously fair) we'll have to try it
> downstream only, and there we can diverge in the implementations.
>
> Please let me know your thoughts on it.

Thanks!

-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
