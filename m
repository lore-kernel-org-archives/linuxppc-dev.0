Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 10009DDE16
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 16:18:53 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l1E5IpPe014341
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 22:18:51 -0700 (MST)
Message-ID: <45D29BBA.7090401@freescale.com>
Date: Tue, 13 Feb 2007 23:18:50 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: delete boot-cpu and chosen nodes from all DTS
	files
References: <11713852392294-git-send-email-timur@freescale.com>
	<20070214003119.GF11491@localhost.localdomain>
In-Reply-To: <20070214003119.GF11491@localhost.localdomain>
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

>> -       chosen {
>> -               name = "chosen";
>> -               linux,platform = <0>;
>> -               interrupt-controller = <10c00>;
>> -               linux,phandle = <400>;
>> -       };
>> -
> 
> Um.. at least the interrupt-controller property here should be fixed,
> and thus should probably remain in the dts.

Can you be more specific?  I'm not familiar with this board, so I don't 
really know what you're talking about.
