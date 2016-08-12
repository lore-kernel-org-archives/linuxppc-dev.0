Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9jbW1lmfzDr1k
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 21:39:35 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7CBd9V2001342
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 07:39:32 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24rtx4bd1n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 07:39:32 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Fri, 12 Aug 2016 08:39:30 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 54B8D352006C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 07:39:07 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7CBdRvH4722802
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 08:39:27 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7CBdRWa022329
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 08:39:27 -0300
Subject: Re: [PATCH v4] powerpc/pseries: use pci_host_bridge.release_fn() to
 kfree(phb)
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 gwshan@linux.vnet.ibm.com
References: <1470947140-16366-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <42f3e4a5-32bd-5c49-0bd9-7db5d779655c@au1.ibm.com>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Fri, 12 Aug 2016 08:39:23 -0300
MIME-Version: 1.0
In-Reply-To: <42f3e4a5-32bd-5c49-0bd9-7db5d779655c@au1.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <03219ae6-9f9e-fadb-7876-c33b30484bd4@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael,

On 08/12/2016 02:54 AM, Gavin Shan wrote:
 > I don't have more obvious comments except below one nitpicky:

I just addressed/replied this in the other e-mail; i think it's OK,
and Andrew/cxl is OK w/ it too.

 > Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>


On 08/12/2016 03:06 AM, Andrew Donnellan wrote:
>> Suggested-By: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Tested-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com> # cxl
>
> Does this justify a Cc: stable?

I'd think so, since this prevents an oops & crash (w/ panic_on_oops).
Do you agree?

Thanks!

-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
