Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 77E8DDDDFA
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 01:03:43 +1100 (EST)
Message-ID: <4733163C.6070406@freescale.com>
Date: Thu, 08 Nov 2007 07:59:24 -0600
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>, Milton Miller <miltonm@bga.com>,
	ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: Merge dtc
References: <9a3f3582990ad94feb76770e82c50bdd@bga.com>	<20071018195926.GA22887@uranus.ravnborg.org>	<20071019014510.GD30283@localhost.localdomain>	<1b5c57d93e45d94d007b543ea5e2de02@bga.com>	<20071019065530.GA27017@localhost.localdomain>	<20071019070718.GA28099@uranus.ravnborg.org>	<20071019071033.GB27017@localhost.localdomain>	<20071019184249.GA32015@uranus.ravnborg.org>
	<20071031024508.GB7772@localhost.localdomain>
In-Reply-To: <20071031024508.GB7772@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
>
> Ok.  I'll use this version in my next spin; except for adding one
> dependency you missed, and removing one which should never have been
> there (unneccessary #include, which I've already fixed in dtc
> upstream).
> 


I think if we embed the DTC in the kernel tree, we should
wait until it supports /dts-v1/ files first.

jdl
