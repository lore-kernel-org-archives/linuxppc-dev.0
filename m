Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 0C5EADDD08
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 01:38:52 +1100 (EST)
Message-ID: <45D5C1F5.4090004@freescale.com>
Date: Fri, 16 Feb 2007 08:38:45 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: add of_get_mac_address() and update fsl_soc.c
	to use it
References: <1171408247467-git-send-email-timur@freescale.com>
	<1171411219.20192.118.camel@localhost.localdomain>
	<01b23edfa0a058ae8a119594abb51e01@kernel.crashing.org>
	<45D4C8AF.80607@freescale.com>
	<d31154b8a4b63cac9aec9a93382ef06c@kernel.crashing.org>
In-Reply-To: <d31154b8a4b63cac9aec9a93382ef06c@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:

> Since you are planning to at a later date (hopefully soon :-) )
> remove this handling of "address" completely again, I'm sure I
> can live with it -- objection withdrawn ;-)

Thank you.  Once U-Boot and the kernel is updated with my patches, the 
next step is to fix all of the DTS files to only define local-mac-address.
