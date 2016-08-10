Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8lxm6lDszDqdr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 08:22:04 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7AMIxKA058484
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 18:22:01 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24qm9ra7pf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 18:22:01 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Wed, 10 Aug 2016 19:21:59 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id B4BD71DC0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 18:21:48 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7AMLvMJ26608102
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 19:21:57 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7AMLvRT023064
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 19:21:57 -0300
Subject: Re: [PATCH v3] powerpc/pseries: use pci_host_bridge.release_fn() to
 kfree(phb)
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 gwshan@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com
References: <1470865522-28046-1-git-send-email-mauricfo@linux.vnet.ibm.com>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Wed, 10 Aug 2016 19:21:53 -0300
MIME-Version: 1.0
In-Reply-To: <1470865522-28046-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <8ec08ac4-212c-0496-686b-e3876afd152a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/10/2016 06:45 PM, Mauricio Faria de Oliveira wrote:
> Changelog:
>  - v3: different approach: struct pci_host_bridge.release_fn()
>  - v2: different approach: struct pci_controller.refcount

Oops, the v3 submission has no cover letter, so the subject changed
a bit from what was in v2.  This is the old subject & archive link:

[PATCH v2 0/2] powerpc: fix oops in pcibios_release_device() after 
pcibios_free_controller() [1]

https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-August/147351.html

-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
