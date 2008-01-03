Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 41F0BDDECB
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2008 05:15:56 +1100 (EST)
Message-ID: <477D2691.4090104@freescale.com>
Date: Thu, 03 Jan 2008 12:16:49 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>, Jon Smirl <jonsmirl@gmail.com>,
	linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801012027p4be16b92r43af773f4e5ae531@mail.gmail.com>
	<477BADF5.9060003@freescale.com>
	<20080103044432.GB25357@localhost.localdomain>
In-Reply-To: <20080103044432.GB25357@localhost.localdomain>
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

> Instantiating the fabric driver off any node is wrong, precisely
> because it is an abstraction.  The fabric driver should be
> instantiated by the platform code.

Can you tell me how to do that?


-- 
Timur Tabi
Linux Kernel Developer @ Freescale
