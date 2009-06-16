Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1F381B71AE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 10:01:37 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6BB9BDDD1C
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 10:01:35 +1000 (EST)
Message-Id: <A70DE565-928D-4BB4-9BD3-E57A68CC9B86@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1243351302-32062-3-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH 2/2] [PATCH 2/2 v2] qe: add polling timeout to
	qe_issue_cmd()
Date: Tue, 16 Jun 2009 18:58:58 -0500
References: <1243351302-32062-1-git-send-email-timur@freescale.com>
	<1243351302-32062-2-git-send-email-timur@freescale.com>
	<1243351302-32062-3-git-send-email-timur@freescale.com>
Cc: geert.uytterhoeven@sonycom.com, linuxppc-dev@ozlabs.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 26, 2009, at 10:21 AM, Timur Tabi wrote:

> The qe_issue_cmd() function (Freescale PowerPC QUICC Engine library)  
> polls on
> a register until a status bit changes, but does not include a  
> timeout to
> handle the situation if the bit never changes.  Change the code to  
> use the new
> spin_event_timeout() macro, which simplifies polling on a register  
> without
> a timeout.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> This patch depends on my previous patch, "powerpc: introduce macro
> spin_event_timeout()".
>
> arch/powerpc/sysdev/qe_lib/qe.c |    9 ++++++---
> 1 files changed, 6 insertions(+), 3 deletions(-)

applied to next

- k
