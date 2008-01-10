Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A1212DE005
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 14:36:57 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0A3atv4018784
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 22:36:55 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0A3asXM171066
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 20:36:54 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0A3asIe009739
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 20:36:54 -0700
Date: Wed, 9 Jan 2008 21:36:31 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH 2/5] Warp Base Platform - dts
Message-ID: <20080109213631.1cffa6bf@zod.rchland.ibm.com>
In-Reply-To: <47859224.70109@pikatech.com>
References: <47852C41.8000506@pikatech.com> <47852CB3.3000208@pikatech.com>
	<20080110024753.GC17816@localhost.localdomain>
	<47858D89.4070706@pikatech.com>
	<20080109211758.26c8e235@zod.rchland.ibm.com>
	<47859224.70109@pikatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 09 Jan 2008 22:33:56 -0500
Sean MacLennan <smaclennan@pikatech.com> wrote:

> Ok, the FPGA is off the EBC, I found it in the documentation.
> 
> Under the ebc, I notice the walnut has @n,m. What are n,m? Are they tied 
> to chip selects?

chip select,offset.

> The FPGA is CS2 according to the documentation. Do I make it fpga@2,0?

If the fpga is on chip select 2, offset 0 from that, yes.  Otherwise,
substitute the proper offset in place of 0.

The ranges property of the EBC node will do the actual address
translation.

josh
