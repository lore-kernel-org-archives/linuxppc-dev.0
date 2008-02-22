Return-Path: <jacmet@gmail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.187])
	by ozlabs.org (Postfix) with ESMTP id 2C07BDDE36
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 12:36:32 +1100 (EST)
Received: by mu-out-0910.google.com with SMTP id w8so327762mue.1
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 17:36:30 -0800 (PST)
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] [USB POWERPC] ehci-fsl: add PPC_MPC837x to default y
References: <20080221195021.GC12896@localhost.localdomain>
	<9AD13D2E-B57F-4F19-B89C-C8A83157E0F2@kernel.crashing.org>
	<20080221203058.GA18624@localhost.localdomain>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Fri, 22 Feb 2008 02:36:27 +0100
In-Reply-To: <20080221203058.GA18624@localhost.localdomain> (Anton Vorontsov's
	message of "Thu\, 21 Feb 2008 23\:30\:58 +0300")
Message-ID: <87bq6993hg.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Anton" == Anton Vorontsov <avorontsov@ru.mvista.com> writes:

Hi,

 Anton>  config USB_EHCI_FSL
 Anton> -	bool
 Anton> -	depends on USB_EHCI_HCD
 Anton> +	bool "Support for Freescale on-chip EHCI USB controller"
 Anton> +	depends on USB_EHCI_HCD && FSL_SOC
 Anton>  	select USB_EHCI_ROOT_HUB_TT
 Anton> -	default y if MPC834x || PPC_MPC831x

Notice that I have a patch in the USB queue which fixes up the MPC834x
symbol (PPC_MPC834x instead of MPC834x) so this patch won't apply.

-- 
Bye, Peter Korsgaard
