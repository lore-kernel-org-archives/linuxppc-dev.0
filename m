Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1C146DDECC
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 05:40:27 +1100 (EST)
Date: Tue, 13 Feb 2007 12:37:38 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Becky Bruce <bgill@freescale.com>
Subject: Re: [PATCH] powerpc: UPDATED Don't write reserved values to
	MAS1[TSIZE]
In-Reply-To: <Pine.LNX.4.61.0702121741350.11175@ld2044.am.freescale.net>
Message-ID: <Pine.LNX.4.64.0702131237220.23923@localhost.localdomain>
References: <Pine.LNX.4.61.0702121741350.11175@ld2044.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 12 Feb 2007, Becky Bruce wrote:

> Some of the current tlbwe instructions early on in head_fsl_booke.S take
> advantage of unarchitected behavior that allows the writing of reserved
> values to the TSIZE field.  This patch corrects that, as well as an error
> where an unitialized (by linux) value was written into a MAS register and
> used for a tlbwe.
>
> Correct this for both arch/ppc and arch/powerpc.
>
> Signed-off-by: Becky Bruce <becky.bruce@freescale.com>

applied.

- k
