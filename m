Return-Path: <balbir@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EDF89DDE3A
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Dec 2007 23:28:42 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lBVBQ4f4007454
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Dec 2007 06:26:04 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBVCSSq1156406
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Dec 2007 05:28:28 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lBVCSRbS016028
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Dec 2007 05:28:28 -0700
Message-ID: <4778E037.6000001@linux.vnet.ibm.com>
Date: Mon, 31 Dec 2007 17:57:35 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
MIME-Version: 1.0
To: FUJITA Tomonori <tomof@acm.org>
Subject: Re: SCSI errors on powerpc with 2.6.24-rc6-mm1
References: <47733C01.1080002@linux.vnet.ibm.com>
	<20071228143043U.fujita.tomonori@lab.ntt.co.jp>
	<4774A74B.3000105@linux.vnet.ibm.com>
	<20071228165115O.tomof@acm.org>
In-Reply-To: <20071228165115O.tomof@acm.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@ozlabs.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
Reply-To: balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

FUJITA Tomonori wrote:
> 
> Oops, it's for -mm.
> 

Hi,

I just tested this patch and it works fine for me so far.

Tested-by: Balbir Singh <balbir@linux.vnet.ibm.com>

-- 
	Warm Regards,
	Balbir Singh
	Linux Technology Center
	IBM, ISTL
