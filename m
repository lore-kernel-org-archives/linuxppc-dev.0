Return-Path: <michaelbarkowski@ruggedcom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E9ADDB6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 02:03:00 +1000 (EST)
Received: from mail.ruggedcom.com (mail.ruggedcom.com [204.50.190.93])
	by ozlabs.org (Postfix) with ESMTP id 37E9BDDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 02:02:58 +1000 (EST)
Received: from [10.200.19.236] (unknown [10.200.19.236])
	by rceng01.eng.lan (Postfix) with ESMTP id 6D13A14E72C
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2009 12:02:56 -0400 (EDT)
Message-ID: <4A8AD0AF.4090701@ruggedcom.com>
Date: Tue, 18 Aug 2009 12:02:55 -0400
From: Michael Barkowski <michaelbarkowski@ruggedcom.com>
MIME-Version: 1.0
Subject: Re: [PATCH] mpc8xxx_spi: Fix polarity inversion in chipselect
References: <4A8AC3E8.5070301@ruggedcom.com> <4A8AC5D4.9070602@ruggedcom.com>
In-Reply-To: <4A8AC5D4.9070602@ruggedcom.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton - thanks for the offline correction.

SPI_CS_HIGH means that the device interprets high as active.
The alow flag means there is an inverter somewhere.

My mistake - patch retracted.

-- 
Michael
