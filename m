Return-Path: <sam@ravnborg.org>
Received: from pfepc.post.tele.dk (pfepc.post.tele.dk [195.41.46.237])
	by ozlabs.org (Postfix) with ESMTP id C9BAB67A7A
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Feb 2005 16:38:50 +1100 (EST)
Date: Mon, 7 Feb 2005 06:39:12 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050207053912.GA8078@mars.ravnborg.org>
References: <20050206124014.GA5880@suse.de>
	<20050206215131.GF7686@smtp.west.cox.net>
	<20050206225323.GA16821@mars.ravnborg.org>
	<1107733391.30303.66.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1107733391.30303.66.camel@gaston>
Cc: Tom Rini <trini@kernel.crashing.org>, Olaf Hering <olh@suse.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: make -j12 all fails in uImage target
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 
> We should maybe also have an explicit dependency on vmlinux no ? Or is
> this handled already for the boot dir as a whole ?

This is handled in arch/ppc/MAkefile - so already dealt with.

	Sam
