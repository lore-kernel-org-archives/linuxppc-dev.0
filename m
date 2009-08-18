Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 53DAAB6F31
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 01:17:09 +1000 (EST)
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by ozlabs.org (Postfix) with ESMTP id CA75BDDD1B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 01:17:08 +1000 (EST)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1MdQQn-000364-Vm
	for linuxppc-dev@ozlabs.org; Tue, 18 Aug 2009 17:17:02 +0200
Received: from 24.114.226.27 ([24.114.226.27])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2009 17:17:01 +0200
Received: from michaelbarkowski by 24.114.226.27 with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2009 17:17:01 +0200
To: linuxppc-dev@ozlabs.org
From: Michael Barkowski <michaelbarkowski@ruggedcom.com>
Subject: Re: [PATCH] mpc8xxx_spi: Fix polarity inversion in chipselect
Date: Tue, 18 Aug 2009 11:16:36 -0400
Message-ID: <4A8AC5D4.9070602@ruggedcom.com>
References: <4A8AC3E8.5070301@ruggedcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
In-Reply-To: <4A8AC3E8.5070301@ruggedcom.com>
Sender: news <news@ger.gmane.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Barkowski wrote:
> If we use open firmware, then alow_flags handles active-low
> chipselects, which is the same as SPI_CS_HIGH. This patch fixes the
> double negative.

Hang on - I missed your most recent patches to spi_mpc8xxx

--Michael
