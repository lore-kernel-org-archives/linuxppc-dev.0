Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 6CD171007D1
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Nov 2009 21:26:50 +1100 (EST)
Date: Fri, 27 Nov 2009 11:26:41 +0100
From: Anatolij Gustschin <agust@denx.de>
To: "Tirumala Reddy Marri" <tmarri@amcc.com>
Subject: Re: [PATCH v2] ppc440spe-adma: adds updated ppc440spe adma driver
Message-ID: <20091127112641.5bcb9009@wker>
In-Reply-To: <AC5E1C3367E37D44970B81A6ADD1DA2C08642A43@SDCEXCHANGE01.ad.amcc.com>
References: <1259186722-15012-1-git-send-email-agust@denx.de>
	<AC5E1C3367E37D44970B81A6ADD1DA2C08642A43@SDCEXCHANGE01.ad.amcc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: wd@denx.de, dzu@denx.de, Yuri
	Tikhonov <yur@emcraft.com>, linux-raid@vger.kernel.org,
	linuxppc-dev@ozlabs.org, dan.j.williams@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Tirumala Reddy Marri" <tmarri@amcc.com> wrote:

> Why are we having separate directory for 440spe. Can this be generalized
> arch/dma/ppc4xx/ppc4xx_dma.c ?

currently there is only tested support for 440spe. If the driver
will be extended to support other CPUs, then the renaming can be
done while adding support for other CPUs. 'arch/' is not correct,
it should be 'driver/'.

Best regards,
Anatolij

--
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
