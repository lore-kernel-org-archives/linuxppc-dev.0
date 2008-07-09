Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 25D6BDDEF7
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 07:53:02 +1000 (EST)
Subject: Re: Two pci patches that are prereq's for MPC5121 pci
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: jcrigby@gmail.com
In-Reply-To: <4b73d43f0807091407w31280a43tbd07ec8a1aca1a93@mail.gmail.com>
References: <4b73d43f0807091407w31280a43tbd07ec8a1aca1a93@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 10 Jul 2008 07:52:55 +1000
Message-Id: <1215640375.4392.0.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-07-09 at 15:07 -0600, John Rigby wrote:
> Ben,
> 
> Could you pick up these two powerpc pci patches.  Grant Likely ack'd
> them both. No one nak'd them.
> 
> powerpc: pci config cleanup [rev2]
> http://patchwork.ozlabs.org/linuxppc/patchcontent?id=19299

Hrm.. I'm not necessarily fan of the above but I'll give a second look.

> powerpc: Move mpc83xx_add_bridge to fsl_pci.c [rev2]
> http://patchwork.ozlabs.org/linuxppc/patchcontent?id=19300

FSL stuff though go via Kumar.

Cheers,
Ben.
