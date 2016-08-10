Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8l8q4Zc5zDr2m
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 07:46:35 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7ALhkuo051066
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 17:46:33 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24qm9rtraf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 17:46:32 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Wed, 10 Aug 2016 18:46:31 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 19B581DC0051
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 17:46:19 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7ALkRJV4636682
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 18:46:27 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7ALkRkQ023506
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 18:46:27 -0300
Subject: Re: [PATCH v2 1/2] powerpc: add refcount to struct pci_controller
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1470789844-16401-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1470789844-16401-2-git-send-email-mauricfo@linux.vnet.ibm.com>
 <5c42993e-208e-34a5-0d5e-48d9df86fa49@au1.ibm.com>
 <3106d6ec-96b3-1fdd-5384-4f133f2df559@linux.vnet.ibm.com>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Wed, 10 Aug 2016 18:46:24 -0300
MIME-Version: 1.0
In-Reply-To: <3106d6ec-96b3-1fdd-5384-4f133f2df559@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <4d405023-6d98-0b15-f33b-b8a273ca480a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/10/2016 10:53 AM, Mauricio Faria de Oliveira wrote:
> I'll go down that path for a PATCH v3.

That is,
'powerpc/pseries: use pci_host_bridge.release_fn() to kfree(phb)'

-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
