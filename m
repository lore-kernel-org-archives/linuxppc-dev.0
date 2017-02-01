Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDB5b5qJzzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 05:11:15 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v11I46SO048585
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Feb 2017 13:11:12 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28bbuqy93m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Feb 2017 13:11:12 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 1 Feb 2017 11:11:10 -0700
Date: Wed, 1 Feb 2017 10:11:03 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] powerpc/pseries: Dynamically increase RMA size
References: <20160805061041.GA31857@us.ibm.com>
 <20160809171131.GA2329@us.ibm.com>
 <87wpdatqrt.fsf@concordia.ellerman.id.au>
 <2499748.LKgOIUjhgo@morokweng>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2499748.LKgOIUjhgo@morokweng>
Message-Id: <20170201181103.GA30729@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thiago Jung Bauermann [bauerman@linux.vnet.ibm.com] wrote:
> Instead of this method of trying a small RMA size and rebooting to try a 
> bigger size, could the "min RMA percentage of total RAM" field of the 
> ibm_architecture_vec be used?

We tried that and concluded that even 1% could end up reserving a lot of
memory on systems with lot of memory.

Sukadev
