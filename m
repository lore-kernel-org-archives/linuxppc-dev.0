Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5F066B7ED9
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 25 May 2010 05:13:11 +1000 (EST)
Subject: Re: [PATCH v3 5/5] fsl_msi: add removal path and probe failing path
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1271925099-29100-5-git-send-email-leoli@freescale.com>
Date: Mon, 24 May 2010 14:13:05 -0500
Message-Id: <A2AD922B-1EB7-47EB-9044-ECBDA3A9D1B5@kernel.crashing.org>
References: <1271925099-29100-1-git-send-email-leoli@freescale.com>
	<1271925099-29100-2-git-send-email-leoli@freescale.com>
	<1271925099-29100-3-git-send-email-leoli@freescale.com>
	<1271925099-29100-4-git-send-email-leoli@freescale.com>
	<1271925099-29100-5-git-send-email-leoli@freescale.com>
To: Li Yang <leoli@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 22, 2010, at 3:31 AM, Li Yang wrote:

> Also cleanup the probe function.
> 
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_msi.c |   36 ++++++++++++++++++++++++++++++------
> arch/powerpc/sysdev/fsl_msi.h |    1 +
> 2 files changed, 31 insertions(+), 6 deletions(-)

applied to next

- k
