Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 1E4C8DDFDD
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 14:33:57 +1100 (EST)
Message-ID: <47859224.70109@pikatech.com>
Date: Wed, 09 Jan 2008 22:33:56 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/5] Warp Base Platform - dts
References: <47852C41.8000506@pikatech.com><47852CB3.3000208@pikatech.com><20080110024753.GC17816@localhost.localdomain><47858D89.4070706@pikatech.com>
	<20080109211758.26c8e235@zod.rchland.ibm.com>
In-Reply-To: <20080109211758.26c8e235@zod.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ok, the FPGA is off the EBC, I found it in the documentation.

Under the ebc, I notice the walnut has @n,m. What are n,m? Are they tied 
to chip selects?

The FPGA is CS2 according to the documentation. Do I make it fpga@2,0?

Cheers,
    Sean
