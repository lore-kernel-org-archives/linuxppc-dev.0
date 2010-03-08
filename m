Return-Path: <albrecht.dress@arcor.de>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A261AB7CF5
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Mar 2010 03:32:33 +1100 (EST)
Message-ID: <27310604.1268065948452.JavaMail.ngmail@webmail08.arcor-online.net>
Date: Mon, 8 Mar 2010 17:32:28 +0100 (CET)
From: "Albrecht Dreﬂ" <albrecht.dress@arcor.de>
To: agust@denx.de, grant.likely@secretlab.ca
Subject: Re: mpc512x uart: testers wanted
In-Reply-To: <20100308151912.14847a74@wker>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20100308151912.14847a74@wker> <1267978529.2306.0@antares>
	<fa686aa41003071645x70dff5d7s89db66416bcc4a0d@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Anatolij:

> > Anatolij, could you please look into this?
> 
> I'll look into this tomorrow, need to finish USB support now.
> Unfortunately the patch doesn't apply on top of Linus' tree as
> patches for reworked MPC5121 PSC UART support have been merged.
> Albrecht, could you please rebase your patch?

Against linux/kernel/git/torvalds/linux-2.6.git?  Will do that tomorrow...  Grant, do you need a patch against Linus' tree, or against a released version, or against your tree?

> BTW, the prescaler /16 or /10 was mentioned in the MPC5121e
> Preliminary Reference Manual, Rev.0. This seems to be the
> reason for the usage of /16 prescaler in the code. Since
> newer manuals only mention /32 or /10 prescaler, this should
> be corrected/tested. I'll test it later.

Dumb question: do you use U-Boot to boot your processor?  If I interpret the code [1] correctly, it also uses the /16 prescaler!  Or did I miss something?

Best, Albrecht.

[1] <http://git.denx.de/cgi-bin/gitweb.cgi?p=u-boot.git;a=blob;f=cpu/mpc512x/serial.c;h=ec2f41bb36dcfa9079d7890866a3aeec716ea124;hb=HEAD>

Sexy Stars bei den Oscars! Fotostrecken und alle aktuellen Infos zu Filmen und Preisen jetzt im Oscar-Special von Arcor.de: http://www.arcor.de/rd/footer.oscar
