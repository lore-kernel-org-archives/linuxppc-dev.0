Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tk54R3G6fzDw5p
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 17:54:46 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBL6rsGj079237
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 01:54:44 -0500
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27fmpu8nsm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 01:54:44 -0500
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 21 Dec 2016 12:24:41 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id E1BECE0064
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 12:25:19 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBL6sbEd32899210
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 12:24:37 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBL6sZF2024072
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 12:24:36 +0530
Subject: Re: [PATCH v3 0/5] powerpc/mm: enable memory hotplug on radix
To: Reza Arbab <arbab@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>
References: <1481831443-22761-1-git-send-email-arbab@linux.vnet.ibm.com>
 <3aac2741-998f-88f0-29bf-eb2bb117a0d6@gmail.com>
 <20161219175819.2rj6mk2wsmykrw43@arbab-laptop.austin.ibm.com>
Cc: Alistair Popple <apopple@au1.ibm.com>, Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Wed, 21 Dec 2016 12:24:29 +0530
MIME-Version: 1.0
In-Reply-To: <20161219175819.2rj6mk2wsmykrw43@arbab-laptop.austin.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <585A2725.2090809@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/19/2016 11:28 PM, Reza Arbab wrote:
> On Sat, Dec 17, 2016 at 01:38:40AM +1100, Balbir Singh wrote:
>> Do we care about alt maps yet?
> 
> Good question. I'll try to see if/how altmaps might need special
> consideration here.

vmemmap alt-map should be enabled separately and should not be mixed
in this series which tries to just get hotplug working on radix.
