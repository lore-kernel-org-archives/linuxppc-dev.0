Return-Path: <jjalvare@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0rhY5L35zDsS1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 06:29:49 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBIJStjS050911
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 14:29:47 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2exhuk5fbh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 14:29:47 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jjalvare@linux.vnet.ibm.com>;
 Mon, 18 Dec 2017 12:29:45 -0700
Subject: Re: [PATCH v1 4/7] powerpc/kernel Add EEH operations to notify resume
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, alex.williamson@redhat.com, helgaas@kernel.org,
 ruscur@russell.cc, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
 saeedm@mellanox.com
References: <20171213153242.98015-1-bryantly@linux.vnet.ibm.com>
 <20171213153242.98015-5-bryantly@linux.vnet.ibm.com>
 <b2d30341-1945-0331-fb36-d441efc89109@ozlabs.ru>
From: Juan Alvarez <jjalvare@linux.vnet.ibm.com>
Date: Mon, 18 Dec 2017 13:29:37 -0600
MIME-Version: 1.0
In-Reply-To: <b2d30341-1945-0331-fb36-d441efc89109@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Message-Id: <8e76e076-d003-03e0-2ed9-af445a14e326@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Yes, way less. So our current design only supports less than or equal to
256 VFs per PF. That is 256*2 bytes.


On 12/17/17 11:02 PM, Alexey Kardashevskiy wrote:
> It is kind of assumed that the number of VFs is always less than 2048 minus
> rtas call parameters (RTAS_DATA_BUF_SIZE==4096 now)?
