Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1A100DDFD4
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 06:52:30 +1100 (EST)
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <64E593B9-BA2A-4E0B-ACEB-CBEFE79DB3DE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: impact of making dma-mapping api go through dma ops?
Date: Thu, 22 Mar 2007 12:17:25 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev ML <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben,

I was wondering if there was any noticeable performance impact to  
switch ppc64 over to using the dma_mapping_ops.  I'm thinking that  
having ppc32 use the same mechanism might be a good thing to handle a  
number of cases things we currently hack around.  However, I'm  
concerned if there is a noticeable performance impact.

- k
