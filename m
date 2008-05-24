Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8B27DDE06E
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 14:32:51 +1000 (EST)
Message-ID: <48379A6B.4080300@freescale.com>
Date: Fri, 23 May 2008 23:32:43 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 5/7] [POWERPC] 83xx: new board support: MPC8360E-RDK
References: <20080523163811.GA12181@polina.dev.rtsoft.ru>
	<20080523163901.GE16137@polina.dev.rtsoft.ru>
In-Reply-To: <20080523163901.GE16137@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

> 3. QE Serial UCCs (tested to not work with ucc_uart driver, reason
>    unknown, yet);

How far did you get on debugging this?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
