Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zGzLD1V7wzDqlG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 06:17:56 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0AJEWaG025390
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 14:17:54 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fdrt7r5q4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 14:17:53 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 10 Jan 2018 19:17:51 -0000
Subject: Re: [PATCH 10/13] ocxl: Add Makefile and Kconfig
To: Michael Ellerman <michael@ellerman.id.au>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, mpe@ellerman.id.au,
 alastair@au1.ibm.com
References: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
 <ddc10e7f73d714bb02bcac4958fc22ab10f7e129.1513608243.git.fbarrat@linux.vnet.ibm.com>
 <9cf29972-8995-949f-1435-70f0e11071cf@au1.ibm.com>
 <c61dd248-4564-5290-d803-4131278f9383@linux.vnet.ibm.com>
 <7365AFB0-6D6F-4A8D-9C50-8B662CC72227@ellerman.id.au>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 10 Jan 2018 20:17:46 +0100
MIME-Version: 1.0
In-Reply-To: <7365AFB0-6D6F-4A8D-9C50-8B662CC72227@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <e8925791-0dbd-909f-f3ed-5b34f4a16b2c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 10/01/2018 à 00:21, Michael Ellerman a écrit :
> Would also be great to add something describing the relationship to CAPI and cxl. Otherwise people will be confused about whether they need this one or the other one or both.

OK, I'll add something.

   Fred
