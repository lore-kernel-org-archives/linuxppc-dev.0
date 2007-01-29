Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id D4CA4DE046
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 06:32:21 +1100 (EST)
Message-ID: <45BE4BC0.5050402@freescale.com>
Date: Mon, 29 Jan 2007 13:32:16 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add support for the MPC8349E-mITX-GP
References: <11691560171514-git-send-email-timur@freescale.com>	<309FC1DE-9724-4172-BB13-D301D4A783F8@kernel.crashing.org>	<45BA1952.80206@freescale.com>	<EC5E5BA9-F865-40AC-8CA8-9B152AAC0908@kernel.crashing.org>	<45BE2276.5010303@freescale.com>
	<2B16AB83-7726-4C84-B48E-254E8FEF734C@kernel.crashing.org>
In-Reply-To: <2B16AB83-7726-4C84-B48E-254E8FEF734C@kernel.crashing.org>
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

Kumar Gala wrote:

> Well, I'd suggest trying it again based on the latest ITX defconfing  
> and see what happens.  If you need to update both defconfigs to make  
> them consistent I'm fine with that.  Just figured they should be  
> insync (except the removed functionality for ITX-GP).

Ok, I'll make new patch that updates the ITX config file and makes an ITX-GP 
config file and keeps the diffs to a minimum.  I'll submit it when the window 
for 2.6.21 opens.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
