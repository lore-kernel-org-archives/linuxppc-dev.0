Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D264EDDF87
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 22:59:07 +1000 (EST)
Message-Id: <E4AD279E-CA52-4F8C-BA74-15880AA29511@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <489AAB3E.8020507@pobox.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH 2/3] gianfar: Magic Packet and suspend/resume support.
Date: Thu, 7 Aug 2008 07:58:57 -0500
References: <20080625215119.GB11784@loki.buserror.net>
	<489AAB3E.8020507@pobox.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 7, 2008, at 2:58 AM, Jeff Garzik wrote:

> Scott Wood wrote:
>> Signed-off-by: Scott Wood <scottwood@freescale.com>
>> ---
>> Documentation/powerpc/booting-without-of.txt |    5 +-
>> arch/powerpc/sysdev/fsl_soc.c                |    3 +
>> drivers/net/gianfar.c                        |  118 ++++++++++++++++ 
>> +++++++++-
>> drivers/net/gianfar.h                        |   12 ++-
>> drivers/net/gianfar_ethtool.c                |   41 +++++++++-
>> include/linux/fsl_devices.h                  |    1 +
>> 6 files changed, 172 insertions(+), 8 deletions(-)
>
> did this ever get ack'd by Kumar?  I don't have a record of it.
>

A version of this is already in linus's tree.  I just forgot to add  
your Ack to it (and I apologize for that).

git commit d87eb12785c14de1586e3bad86ca2c0991300339

- k
