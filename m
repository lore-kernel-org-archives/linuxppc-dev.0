Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B7CE8684BA
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Oct 2005 02:36:33 +1000 (EST)
Received: from zambia.cambridgebroadband.com (cbluk-gw0.cambridgebroadband.com
	[217.204.121.82])
	by cambridgebroadband.com (8.12.8/8.12.8) with SMTP id j96GaS9a009422
	for <linuxppc-embedded@ozlabs.org>; Thu, 6 Oct 2005 17:36:28 +0100
Date: Thu, 6 Oct 2005 17:36:27 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: linuxppc-embedded@ozlabs.org
Message-Id: <20051006173628.53f25862.ajz@cambridgebroadband.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: mpc8272ads support in linux-2.4
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi list,

I have read that the MPC8272ADS board is supported in linux-2.6.  Has
anybody backported this support to linux-2.4.  I am using linux-2.4.25
from ELDK.  If anyone has a patch I would be very grateful if they
sent it to me.

Regards,

Alex Zeffertt

PS Does anyone know where the master PPC patches are kept?  I.e. the
ones you apply to kernels from kernel.org to get all the stuff that
hasn't yet been upstreamed.
