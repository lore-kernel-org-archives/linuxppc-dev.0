Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D41BE67A0E
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 01:25:09 +1000 (EST)
In-Reply-To: <C5BA91F04186584EB68FD42BB4993E6BC1B5C6@FRQWOLEX01.frequentis.frq>
References: <C5BA91F04186584EB68FD42BB4993E6BC1B5C6@FRQWOLEX01.frequentis.frq>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1225A3AD-A37A-40FF-A997-EA81CFE1467B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [QUESTION] MPC834x DMA Support
Date: Thu, 27 Apr 2006 10:25:02 -0500
To: KRONSTORFER Horst <Horst.KRONSTORFER@frequentis.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 27, 2006, at 5:37 AM, KRONSTORFER Horst wrote:

> hi!
>
> does anyone know if the mpc834x's dma unit supports dma operation
> only between pci and csb or also between csb and csb, f.e. devices
> connected via the lbc (f.e. ram and a dsp)?

You should be able to do csb to csb devices.

- kumar
