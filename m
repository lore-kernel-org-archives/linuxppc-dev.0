Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 31E4CDE17E
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 03:24:56 +1000 (EST)
Message-Id: <5F3E22A9-AC7D-4066-B861-C98755BAE4A8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20090415165009.GA10214@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc/85xx: Add P2020DS board support
Date: Wed, 15 Apr 2009 12:22:48 -0500
References: <1239810564-8403-1-git-send-email-galak@kernel.crashing.org>
	<20090415165009.GA10214@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Ted Peters <ted.peters@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 15, 2009, at 11:50 AM, Anton Vorontsov wrote:

>
> Sorry for bringing this up again... But can we decide on soc's
> compatible scheme and finally remove the device_type = "soc"
> for new boards? "fsl,p2020-soc", "fsl,soc", "simple-bus" maybe?
>
> Thanks,

We can, but I don't want to couple the two issues.  If someone wants  
to work and post patches related to this issue I'm all for it.

- k
