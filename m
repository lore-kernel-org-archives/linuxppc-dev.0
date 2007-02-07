Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 662A4DDE31
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 08:46:36 +1100 (EST)
Message-ID: <45CA48B8.4040301@freescale.com>
Date: Wed, 07 Feb 2007 15:46:32 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: mac-address vs. local-mac-address
References: <45CA41F7.6020700@freescale.com>
	<1170883956.2620.305.camel@localhost.localdomain>
	<45DA66E1-EAB7-4A3A-9347-4564F6A68C0F@kernel.crashing.org>
In-Reply-To: <45DA66E1-EAB7-4A3A-9347-4564F6A68C0F@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> Which means the code in fsl_soc.c is wrong in how it handles the 
> precedence of gianfar:

I agree, and this is the type of thing that we're trying to clear up.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
