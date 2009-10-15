Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B1E4EB7B80
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2009 06:32:31 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n9FJWSK3001054
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 12:32:29 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n9FJZLOO027570
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 14:35:21 -0500 (CDT)
Message-ID: <4AD778E6.7020806@freescale.com>
Date: Thu, 15 Oct 2009 14:32:54 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] hvc_console: returning 0 from put_chars is not an error
References: <1255557226-4403-1-git-send-email-timur@freescale.com>	<200910152041.26646.borntraeger@de.ibm.com>	<4AD770A9.6070509@freescale.com>
	<200910152126.28024.borntraeger@de.ibm.com>
In-Reply-To: <200910152126.28024.borntraeger@de.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, brueckner@linux.vnet.ibm.com,
	Timur Tabi <timur@freescale.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christian Borntraeger wrote:
> About the backends, there are some that spin until the text is delivered (e.g. 
> virtio) , others can drop (e.g. iucv is a connection oriented protocol and it 
> will (and has to) drop if there is no connection). 

Sure, dropping due to not having a connection makes sense.  That's 
different from merely being busy.  Can the iucv code tell the difference 
between those two states?

-Scott
