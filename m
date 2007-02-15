Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 1D72DDDE31
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 02:28:55 +1100 (EST)
Message-ID: <45D47C2F.2050304@freescale.com>
Date: Thu, 15 Feb 2007 09:28:47 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v3] powerpc: delete boot-cpu property from all DTS files
References: <11714885473600-git-send-email-timur@freescale.com>
	<8554ec6810844cd79a8ad3eb2dda33a0@kernel.crashing.org>
In-Reply-To: <8554ec6810844cd79a8ad3eb2dda33a0@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Stuart Yoder <stuart.yoder@freescale.com>,
	g.liakhovetski@gmx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:

> Also, why is there a special header for this in the device tree
> blob?  

I have no idea.  I just know that it's there, and that the DTS files had to be 
cleaned up.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
