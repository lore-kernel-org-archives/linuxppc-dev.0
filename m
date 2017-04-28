Return-Path: <srs0=ipmx=4e=au1.ibm.com=andrew.donnellan@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDhd34q7dzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 15:07:03 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wDhd34F3fz8wJl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 15:07:03 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wDhd308jQz9s8S
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2017 15:07:02 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3S53n8f074035
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2017 01:07:00 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2a3hae4x4a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2017 01:07:00 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 28 Apr 2017 15:06:58 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3S56mhd29622460
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2017 15:06:56 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3S56NrH015215
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2017 15:06:24 +1000
Subject: Re: [PATCH v3] cxl: mask slice error interrupts after first occurrence
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@ozlabs.org
References: <20170428032015.22872-2-alastair@au1.ibm.com>
Cc: frederic.barrat@fr.ibm.com, vaibhav@linux.vnet.ibm.com,
 "Alastair D'Silva" <alastair@d-silva.org>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 28 Apr 2017 15:05:59 +1000
MIME-Version: 1.0
In-Reply-To: <20170428032015.22872-2-alastair@au1.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <6f8edc0d-35d9-bc6b-b6be-d7bbcbb91042@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28/04/17 13:20, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
>
> In some situations, a faulty AFU slice may create an interrupt storm,
> rendering the machine unusable. Since these interrupts are informational
> only, present the interrupt once, then mask it off to prevent it from
> being retriggered until the card is reset.
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

LGTM

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
