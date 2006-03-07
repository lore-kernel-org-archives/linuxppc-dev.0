Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3E9E767B1B
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Mar 2006 11:12:01 +1100 (EST)
In-Reply-To: <F795765B112E7344AF36AA9112796415019ECDE1@xmb-sjc-212.amer.cisco.com>
References: <F795765B112E7344AF36AA9112796415019ECDE1@xmb-sjc-212.amer.cisco.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <54B606C5-BEBA-4241-905F-E53C9240D616@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: System hang and NMI support on 8541
Date: Mon, 6 Mar 2006 18:12:10 -0600
To: Bizhan Gholikhamseh ((bgholikh)) <bgholikh@cisco.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Mar 6, 2006, at 5:39 PM, Bizhan Gholikhamseh ((bgholikh)) wrote:

> Hi All,
> Our custom board 8541 base processor running Linux 2..11 hangs  
> during stress testing. Is there a support for a
> Non Mask able interrupt?

Not sure what kernel ver you are using, but there is a machine check  
pin on the 8541.  The MSR[ME] should always be set so this pin can be  
used (except when are in the MachineCheck handler).

- k
