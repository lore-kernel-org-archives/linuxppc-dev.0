Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx020.isp.belgacom.be (outmx020.isp.belgacom.be
	[195.238.4.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EFF42679FC
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Apr 2006 23:40:15 +1000 (EST)
Received: from outmx020.isp.belgacom.be (localhost [127.0.0.1])
	by outmx020.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k3IDdx1q002012
	for <linuxppc-embedded@ozlabs.org>; Tue, 18 Apr 2006 15:40:03 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: New fs_enet driver : filling platform_data
Date: Tue, 18 Apr 2006 15:40:58 +0200
References: <200604181509.38713.laurent.pinchart@tbox.biz>
	<20060418171317.5f9db046@vitb.ru.mvista.com>
In-Reply-To: <20060418171317.5f9db046@vitb.ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200604181540.58627.laurent.pinchart@tbox.biz>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Vitaly,

> I have posted recently fs_enet driver update to the list - (FS_ENET: use
> PAL for mii management) - you'll find needed platform info updates for
> 8272ads and 866 ads in the patch. I am going to push it rather shortly,
> after I'll correct some minor issues appeared.

Thanks. Which tree is your patched based on ? It doesn't apply cleanly against 
2.6.16.

Laurent Pinchart
