Return-Path: <Simon.Richter@hogyros.de>
Received: from psionic8.psi5.com (psionic.psi5.com [212.112.229.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.psi5.com", Issuer "psi5.com CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 43DA6DE00D
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 19:06:42 +1000 (EST)
Date: Thu, 14 May 2009 10:59:02 +0200
From: Simon Richter <Simon.Richter@hogyros.de>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: [RFC] How to allow selecting mv643xx_eth on Pegasos again
Message-ID: <20090514085902.GA30546@honey.hogyros.de>
References: <20090514064836.GA21486@iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090514064836.GA21486@iram.es>
Cc: LinuxPPC <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I just tried upgrading my PegasosII to 2.6.29, and found that the Marvell
driver shows two Ethernet ports now, one with a MAC address ending in
...:de:ad:01 (which is the port that is not wired to the outside), and the
other one with 00:00:00:00:00:00.

I think some sort of Pegasos specific hack is needed.

   Simon
