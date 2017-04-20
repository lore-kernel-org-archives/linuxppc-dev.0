Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7g283M9tzDqKq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 10:37:52 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3K0Xl30035724
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 20:37:49 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29x745pq2v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 20:37:49 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 20 Apr 2017 10:37:46 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3K0bZNE7340298
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 10:37:43 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3K0b6vj000733
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 10:37:06 +1000
Subject: Re: [PATCH v3 2/2] powerpc/eeh: Clean up and document event handling
 functions
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
References: <20170419073927.29224-1-ruscur@russell.cc>
 <20170419073927.29224-2-ruscur@russell.cc>
Cc: aik@ozlabs.ru
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 20 Apr 2017 10:36:41 +1000
MIME-Version: 1.0
In-Reply-To: <20170419073927.29224-2-ruscur@russell.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <aa65f593-2c0d-47ef-df9a-bc99a6460f78@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19/04/17 17:39, Russell Currey wrote:
> Remove unnecessary tags in eeh_handle_normal_event(), and add function
> comments for eeh_handle_normal_event() and eeh_handle_special_event().
>
> The only functional difference is that in the case of a PE reaching the
> maximum number of failures, rather than one message telling you of this
> and suggesting you reseat the device, there are two separate messages.
>
> Suggested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Russell Currey <ruscur@russell.cc>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
