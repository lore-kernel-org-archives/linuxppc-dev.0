Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 556F2DDE1C
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 08:46:25 +1000 (EST)
Message-ID: <47211CBB.5080000@garzik.org>
Date: Thu, 25 Oct 2007 18:46:19 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Dale Farnsworth <dale@farnsworth.org>
Subject: Re: [PATCH v4] FEC - fast ethernet controller for mpc52xx
References: <20071014075511.GC3000@nd47.coderock.org>
	<4713BA1C.2050604@pobox.com>
	<fa686aa40710180715u23d81adfy83ff65837725fb80@mail.gmail.com>
	<4717B09B.3060800@pobox.com>
	<20071019112700.GD27403@nd47.coderock.org>
	<47206209.8080109@pobox.com>
	<20071025185706.29496.qmail@farnsworth.org>
	<20071025194114.GH3369@nd47.coderock.org>
	<20071025202908.GA2102@xyzzy.farnsworth.org>
In-Reply-To: <20071025202908.GA2102@xyzzy.farnsworth.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, Domen Puncer <domen.puncer@telargo.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dale Farnsworth wrote:
> IMO, it's still a requirement that we call dma_unmap_single() for
> each call to dma_map_single().

Yep...
