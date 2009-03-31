Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0083BDE11F
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 00:32:19 +1100 (EST)
Message-Id: <28E62C76-C60A-4A58-B55E-4EADD3D129A3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20090328210715.27260.66043.stgit@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc: Remove unused symbols from fsl_devices.h
Date: Tue, 31 Mar 2009 08:32:13 -0500
References: <20090328210715.27260.66043.stgit@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Kay Sievers <kay.sievers@vrfy.org>,
	Greg Kroah-Hartmann <greg@kroah.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 28, 2009, at 4:07 PM, Grant Likely wrote:

> From: Grant Likely <grant.likely@secretlab.ca>
>
> Remove old artifacts leftover from the platform driver gianfar and
> fsl_i2c drivers.  These symbols became unused when the drivers
> were migrated over to use the of_platform bus.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
> include/linux/fsl_devices.h |   22 ----------------------
> 1 files changed, 0 insertions(+), 22 deletions(-)


applied

- k
