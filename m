Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9KZk5QvPzDr0d
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 06:37:34 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7BKYXxf075834
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 16:37:32 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24ryvr9ht6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 16:37:32 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Thu, 11 Aug 2016 14:37:30 -0600
Subject: Re: [PATCH 0/2] ibmvfc: FC-TAPE Support
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 james.bottomley@hansenpartnership.com
References: <1470260213-19087-1-git-send-email-tyreld@linux.vnet.ibm.com>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, brking@linux.vnet.ibm.com,
 nfont@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, mpe@ellerman.id.au
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Thu, 11 Aug 2016 13:37:24 -0700
MIME-Version: 1.0
In-Reply-To: <1470260213-19087-1-git-send-email-tyreld@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <57ACE204.7000106@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/03/2016 02:36 PM, Tyrel Datwyler wrote:
> This patchset introduces optional FC-TAPE/FC Class 3 Error Recovery to the
> ibmvfc client driver.
> 
> Tyrel Datwyler (2):
>   ibmvfc: Set READ FCP_XFER_READY DISABLED bit in PRLI
>   ibmvfc: add FC Class 3 Error Recovery support
> 
>  drivers/scsi/ibmvscsi/ibmvfc.c | 11 +++++++++++
>  drivers/scsi/ibmvscsi/ibmvfc.h |  1 +
>  2 files changed, 12 insertions(+)
> 

ping?
