Return-Path: <mkravetz@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1FF3867B7B
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Jul 2006 04:04:54 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6CI4nBa007909
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Jul 2006 14:04:49 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6CI4kjt134490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Jul 2006 12:04:47 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6CI4k1p032721
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Jul 2006 12:04:46 -0600
Date: Wed, 12 Jul 2006 11:05:01 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 0/3] powerpc: Instrument Hypervisor Calls
Message-ID: <20060712180501.GB26984@w-mikek2.beaverton.ibm.com>
References: <20060622225609.GA4877@w-mikek2.ibm.com>
	<20060710203510.GA30793@w-mikek2.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060710203510.GA30793@w-mikek2.ibm.com>
Cc: Bryan Rosenburg <rosnbrg@us.ibm.com>, Christopher Yeoh <cyeoh@samba.org>,
	Nathan Lynch <ntl@pobox.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 10, 2006 at 01:35:10PM -0700, Mike Kravetz wrote:
> #ifdef CONFIG_HCALL_STATS
> #define plpar_hcall_*()		plpar_hcall_*_inst()

To answer my own question, this won't work because plpar_hcall_*()
routines are exported.  So, marcros can't be used.  Still thinking
about the best way to juggle function names for instrumentation.

-- 
Mike
