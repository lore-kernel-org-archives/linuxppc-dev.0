Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Bnfg03dRzF0xS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 15:48:10 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5M5iGT4096799
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 01:48:07 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jru3ug9md-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 01:48:07 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 22 Jun 2018 06:48:06 +0100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Matthew Wilcox <willy@infradead.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 13/26] ppc: Convert mmu context allocation to new IDA API
In-Reply-To: <20180622043815.GA31255@bombadil.infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
 <20180621212835.5636-14-willy@infradead.org>
 <20180622121511.00ae9d00@roar.ozlabs.ibm.com>
 <20180622043815.GA31255@bombadil.infradead.org>
Date: Fri, 22 Jun 2018 11:17:59 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87tvpvbcds.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Matthew Wilcox <willy@infradead.org> writes:



> this situation from occurring (like, oh i don't know, this function only
> being called on process exit, so implicitly only called once per context).
>

That is correct.
