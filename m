Return-Path: <dedekind1@gmail.com>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.nokia.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 81BF5B6ED0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 May 2010 00:13:19 +1000 (EST)
Received: from mgw-mx06.nokia.com (mgw-mx06.nokia.com [192.100.122.233])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id
	o44Ds9bv022487
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 May 2010 16:54:10 +0300
Subject: Re: [PATCH] mpc5121_nfc: Changed SVR check to allow MPC5123.
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Steve Deiters <SteveDeiters@BASLER.com>
In-Reply-To: <181804936ABC2349BE503168465576460E95836C@exchserver.basler.com>
References: <181804936ABC2349BE503168465576460E95836C@exchserver.basler.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 04 May 2010 16:47:43 +0300
Message-ID: <1272980863.3702.10.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-04-28 at 17:33 -0500, Steve Deiters wrote:
> The revision in SVR for MPC5123 is 3.  The NFC is the same as MPC5121
> revision 2.
> 
> ---
>  drivers/mtd/nand/mpc5121_nfc.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 

Please, add your Signed-off-by and re-send.

-- 
Best Regards,
Artem Bityutskiy (Артём Битюцкий)
