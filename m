Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdz3v3kzHzDqnQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 18:09:30 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5S894ZK010119
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 04:09:28 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23skk0g437-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 04:09:27 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 28 Jun 2016 18:09:25 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3962F2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 18:09:23 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5S89NVw721362
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 18:09:23 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5S89Mrh006321
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 18:09:22 +1000
Subject: Re: [RESEND v7,2/2] cxl: Add set and get private data to context
 struct
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1466750827-3062-1-git-send-email-felix@linux.vnet.ibm.com>
Cc: mikey@neuling.org, mrochs@linux.vnet.ibm.com, manoj@linux.vnet.ibm.com,
 imunsie@au1.ibm.com
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 28 Jun 2016 18:08:52 +1000
MIME-Version: 1.0
In-Reply-To: <1466750827-3062-1-git-send-email-felix@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <75522a94-6e29-5cd4-1ea1-903b7b2df264@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 24/06/16 16:47, Philippe Bergheaud wrote:
> From: Michael Neuling <mikey@neuling.org>
>
> This provides AFU drivers a means to associate private data with a cxl
> context. This is particularly intended for make the new callbacks for
> driver specific events easier for AFU drivers to use, as they can easily
> get back to any private data structures they may use.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com
> Reviewed-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>

As per v3:

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
