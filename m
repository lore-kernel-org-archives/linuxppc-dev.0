Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3F59EDDDFA
	for <linuxppc-dev@ozlabs.org>; Fri,  2 May 2008 08:40:01 +1000 (EST)
Subject: Re: [RFC] [PATCH] vmemmap fixes to use smaller pages
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <481A3A50.3060101@am.sony.com>
References: <1209534108.18023.221.camel@pasglop> <481A3A50.3060101@am.sony.com>
Content-Type: text/plain
Date: Fri, 02 May 2008 08:39:50 +1000
Message-Id: <1209681590.18023.295.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-05-01 at 14:46 -0700, Geoff Levand wrote:
> 
> It doesn't seem to cause problems on PS3, and I added it into
> ps3-linux.git
> as other/powerpc-vmemmap-variable-page-size.diff, but I couldn't get
> it to
> fail without the patch...
>  
> Could you send me your kernel .config?

ps3_defconfig with added vmmemap (which is disabled by default).

Ben.
