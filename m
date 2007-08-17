Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A4509DDEDF
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 22:48:41 +1000 (EST)
In-Reply-To: <18117.22358.723442.148999@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.64.0708170003210.21006@blarg.am.freescale.net>
	<18117.22358.723442.148999@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D6CFE4FC-5112-450B-B13F-2DC40165EB71@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Fix interrupt routing and setup of ULI M1575 on
	FSL boards
Date: Fri, 17 Aug 2007 07:50:29 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 17, 2007, at 3:07 AM, Paul Mackerras wrote:

> Kumar Gala writes:
>
>> The interrupt routing in the device trees for the ULI M1575 was
>> inproperly using the interrupt line field as pci function.  Fixed
>> up the device tree's to actual conform for to specification and
>> changed the interrupt mapping code so it just uses a static mapping
>> setup as follows:
>
> This is a big patch to be going in post -rc3.  Is it really fixing a
> regression or a serious bug?

Its a regression in that the ULI M1575 doesn't really work properly  
on some of these boards in certain situations.

- k
