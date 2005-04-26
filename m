Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 742C267AC6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Apr 2005 05:23:20 +1000 (EST)
In-Reply-To: <056601c54a94$6d0cae50$2f010a0a@foundation.com>
References: <056601c54a94$6d0cae50$2f010a0a@foundation.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0959397aecc420eff4922c4b2b826976@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 26 Apr 2005 14:23:17 -0500
To: "Stuart Yoder" <stuart.yoder@conformative.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PowerPC + SMP
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Apr 26, 2005, at 2:16 PM, Stuart Yoder wrote:

> Thanks Kumar.
>
> How can I know what assumptions the kernel makes about the state of the
>  CPU/system when it begins execution? Is this clearly documented
>  anywhere?

Unfortunately this is something we dont have clearly documented today.  
As they say the code is the documentation.

> Do you know of open source bootloaders for Linux that would demonstrate
>  how to set up the CPUs as the Linux kernel expects.

No, maybe take a look at linuxbios, not sure if it does SMP or not.  
However, I'm not aware of any open source PPC SMP bootloaders.

- kumar
