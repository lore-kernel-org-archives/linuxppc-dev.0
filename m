Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 5487EDDE19
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 23:59:44 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/3] 82xx: Parse SMC serial device node in DTS
Date: Tue, 17 Jul 2007 15:06:42 +0200
References: <469B33F9.2080604@windriver.com> <200707171406.03455.arnd@arndb.de>
	<1184680385.18501.51.camel@mark>
In-Reply-To: <1184680385.18501.51.camel@mark>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707171506.43102.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 17 July 2007, Mark Zhan wrote:
> Yes, basically I agree what you say. That should be the right way. 
> 
> but, the current situation is that: in all DTS files that are using smc
> or scc as uart device, all device node definitions have the same
> "compatible" property -- "cpm_uart"
> 
> So what I do here is just following the upstream source tree.
> 

Well, AFAICS, all of them currently use scc. The 8xx platforms don't
even build correctly in the mainline kernel, so I guess it would
be good to change them to also list fsl,cpm-smc in the compatible
property.

	Arnd <><
