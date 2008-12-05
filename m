Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6CF7ADDDED
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Dec 2008 04:14:32 +1100 (EST)
Message-ID: <49396171.4050301@freescale.com>
Date: Fri, 05 Dec 2008 11:14:25 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/83xx: Fix few build errors with
	CONFIG_QUICC_ENGINE=n
References: <20081205165504.GA30966@oksana.dev.rtsoft.ru>
	<6D7DC36C-52D0-4E92-8312-B3780A7BDF73@kernel.crashing.org>
In-Reply-To: <6D7DC36C-52D0-4E92-8312-B3780A7BDF73@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> this doesn't seem critical right now so I'd say we wait for .29

I agree.  None of the defconfigs or default behavior expose this bug.  I don't
expect anyone to actually turn off the QE in a real-world situation.

-- 
Timur Tabi
Linux kernel developer at Freescale
