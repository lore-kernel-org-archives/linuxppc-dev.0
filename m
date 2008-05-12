Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D6D7FDDF51
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 02:46:53 +1000 (EST)
Message-ID: <48287476.1050005@freescale.com>
Date: Mon, 12 May 2008 11:46:46 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: Re: [PATCH] Add null pointer check to of_find_property
References: <1210187999-20274-1-git-send-email-timur@freescale.com>
In-Reply-To: <1210187999-20274-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Update function of_find_property() to return NULL if the device_node passed
> to it is also NULL.  Otherwise, passing NULL will cause a null pointer
> dereference.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

Paul, please pick this up for 2.6.26.  The legacy_serial driver will crash
without it if there's no 'chosen' node in the device tree.  I'm sure there are
other drivers that would crash similarly if given a device tree with missing nodes.

-- 
Timur Tabi
Linux kernel developer at Freescale
