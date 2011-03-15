Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 20BB7B705F
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2011 06:09:34 +1100 (EST)
Subject: Re: [PATCH] update name of pic-no-reset property
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1300214278-1588-1-git-send-email-stuart.yoder@freescale.com>
Date: Tue, 15 Mar 2011 14:09:26 -0500
Message-Id: <D77F0255-1F0C-4411-83E3-9C38DAB6B832@kernel.crashing.org>
References: <1300214278-1588-1-git-send-email-stuart.yoder@freescale.com>
To: Stuart Yoder <stuart.yoder@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 15, 2011, at 1:37 PM, Stuart Yoder wrote:

> From: Stuart Yoder <stuart.yoder@freescale.com>
> 
> -changed name from 'no-reset' to 'pic-not-reset' be consisent with
> Meador Inge's open pic binding patch
> -update definition
> 
> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
> ---
> Documentation/powerpc/dts-bindings/fsl/mpic.txt |    7 +++++--
> 1 files changed, 5 insertions(+), 2 deletions(-)

applied, I squashed this with the mpic binding patch.

- k
