Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B6925DDF45
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 23:45:24 +1100 (EST)
Message-Id: <6B9965AF-F6B7-427E-B1D9-68CBB7540372@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080327163608.81f87de2.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] Remove CONFIG_PCI_LEGACY from some configs
Date: Thu, 27 Mar 2008 07:45:06 -0500
References: <20080327163608.81f87de2.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 27, 2008, at 12:36 AM, Stephen Rothwell wrote:
> This will remove some build warnings and doesn't stop us building any
> drivers that we were building previously with these configs.
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Doesn't this hide issues on the defconfigs most often built for PPC?

- k
