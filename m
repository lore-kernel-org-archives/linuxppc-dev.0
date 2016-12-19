Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tj7vC2MZmzDwNl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 04:58:30 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBJHs2FC030398
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 12:58:26 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27ekkxub2n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 12:58:26 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Mon, 19 Dec 2016 12:58:25 -0500
Date: Mon, 19 Dec 2016 11:58:20 -0600
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>
Subject: Re: [PATCH v3 0/5] powerpc/mm: enable memory hotplug on radix
References: <1481831443-22761-1-git-send-email-arbab@linux.vnet.ibm.com>
 <3aac2741-998f-88f0-29bf-eb2bb117a0d6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <3aac2741-998f-88f0-29bf-eb2bb117a0d6@gmail.com>
Message-Id: <20161219175819.2rj6mk2wsmykrw43@arbab-laptop.austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Dec 17, 2016 at 01:38:40AM +1100, Balbir Singh wrote:
>Do we care about alt maps yet?

Good question. I'll try to see if/how altmaps might need special 
consideration here.

-- 
Reza Arbab
