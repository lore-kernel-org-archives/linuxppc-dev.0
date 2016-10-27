Return-Path: <jallen@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t4TZ815DQzDvLR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 01:20:31 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9REJ6dm100045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 10:20:29 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26bhexfw73-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 10:20:29 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jallen@linux.vnet.ibm.com>;
 Thu, 27 Oct 2016 08:20:28 -0600
Subject: Re: [PATCH v6 1/3] powerpc/pseries: Correct possible read beyond
 dlpar sysfs buffer
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20161018171803.37287.54834.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <20161018172012.37287.76194.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
Cc: sahilmehta17@gmail.com
From: John Allen <jallen@linux.vnet.ibm.com>
Date: Thu, 27 Oct 2016 09:20:24 -0500
MIME-Version: 1.0
In-Reply-To: <20161018172012.37287.76194.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <49a9a949-c143-abc5-1d5e-e6eac8daf7d3@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/18/2016 12:20 PM, Nathan Fontenot wrote:
> The pasrsing of data written to the dlpar file in sysfs does not correctly
> account for the possibility of reading past the end of the buffer. Correct
> this by updating the buffer parsing code to make a local copy and use the
> strsep() and sysfs_streq() routines to parse the buffer. This also
> separates the parsing code into subroutines to make cleaner.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> ---

Reviewed-by: John Allen <jallen@linux.vnet.ibm.com>
