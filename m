Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 15D1267B5E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Jun 2005 17:04:56 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j5A7A7ux020592
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Jun 2005 10:10:10 +0300 (EEST)
Message-ID: <42A936A9.5080807@intracom.gr>
Date: Fri, 10 Jun 2005 09:43:53 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Guillaume Autran <gautran@mrv.com>
References: <20050517081558.74BA0C1512@atlas.denx.de>	<4289A635.5000509@intracom.gr>
	<4434E283.3000201@eircom.net> <42A8B272.6010206@mrv.com>
In-Reply-To: <42A8B272.6010206@mrv.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: linux/drivers/net/fec_8xx/* vs. linux/arch/ppc/8xx_io/fec.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Guillaume Autran wrote:
> 
> Can anyone tell me what is the difference between:
>    linux/arch/ppc/8xx_io/fec.c

Old driver (AFAIK doesn't work on 2.6)

> and
>    linux/drivers/net/fec_8xx/fec_*

The new driver for 2.6 (for now).

> 
> They both seem to be mpc8xx fec drivers....
> 
> Thanks.
> Guillaume.
> 

Regards

Pantelis
