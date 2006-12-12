Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2DAFD67C30
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 13:21:59 +1100 (EST)
In-Reply-To: <20061211223659.20169.50415.stgit@localhost.localdomain>
References: <20061212012641.5ef493f7@localhost.localdomain>
	<20061211223659.20169.50415.stgit@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CB3BCBF7-D800-4438-A7D5-3798C56F9720@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/4] [POWERPC] cpm2: Updates for CPM2 pic
Date: Mon, 11 Dec 2006 20:21:52 -0600
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 11, 2006, at 4:36 PM, Vitaly Bordug wrote:

>
> This contains important fixes for the CPM2 PIC code. Eliminated
> CPM_IRQ_OFFSET, pulling the respective interrupt numbers from the  
> interrupt
> mapping. Updated devicetree files to reflect that. Changed direct
> IC-related IO accesses to the IO accessors.

Since your changing the interrupt numbers, do you mind changing the  
interrupt sense to match ipic?  I was hoping to introduce a generic  
host_xlate function to cover the various embedded pic's.

- kumar
