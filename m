Return-Path: <gautran@mrv.com>
Received: from mailman.xyplex.com (mailman.xyplex.com [140.179.176.116])
	by ozlabs.org (Postfix) with ESMTP id A3DF467B3B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Jun 2005 07:18:35 +1000 (EST)
Message-ID: <42A8B272.6010206@mrv.com>
Date: Thu, 09 Jun 2005 17:19:46 -0400
From: Guillaume Autran <gautran@mrv.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <20050517081558.74BA0C1512@atlas.denx.de>	<4289A635.5000509@intracom.gr>
	<4434E283.3000201@eircom.net>
In-Reply-To: <4434E283.3000201@eircom.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Subject: linux/drivers/net/fec_8xx/* vs. linux/arch/ppc/8xx_io/fec.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Can anyone tell me what is the difference between:
    linux/arch/ppc/8xx_io/fec.c
and
    linux/drivers/net/fec_8xx/fec_*

They both seem to be mpc8xx fec drivers....

Thanks.
Guillaume.

-- 
=======================================
Guillaume Autran
Senior Software Engineer
MRV Communications, Inc.
Tel: (978) 952-4932 office
E-mail: gautran@mrv.com
======================================= 
