Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y56hb6vBYzDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Oct 2017 14:14:23 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v923EDDw107335
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 1 Oct 2017 23:14:21 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2db4ruwv27-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Oct 2017 23:14:20 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Sun, 1 Oct 2017 23:14:20 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: ego@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, paulus@samba.org,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, akshay.adiga@linux.vnet.ibm.com
Subject: Re: [PATCH] powernv: Add OCC driver to mmap sensor area
In-Reply-To: <1506667651-32301-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1506667651-32301-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Date: Mon, 02 Oct 2017 14:14:10 +1100
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87bmlqutq5.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> writes:
> This driver provides interface to mmap the OCC sensor area
> to userspace to parse and read OCC inband sensors.

Why?

Is this for debug? If so, the existing exports interface should be used.

If there's actual sensors, we already have two ways of exposing sensors
to Linux: the OPAL_SENSOR API and the IMC API.

Why this method and not use the existing ones?

-- 
Stewart Smith
OPAL Architect, IBM.
