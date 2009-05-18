Return-Path: <kosmo@semihalf.com>
Received: from semihalf.com (semihalf.com [206.130.101.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A833CDE01F
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 23:57:30 +1000 (EST)
From: Piotr =?iso-8859-2?q?Zi=EAcik?= <kosmo@semihalf.com>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 08/12] mpc5121: Added I2C support.
Date: Mon, 18 May 2009 15:57:11 +0200
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<fa686aa40905061941p6fd4b03dt1097cf4d16bdd665@mail.gmail.com>
	<4A028182.3040107@grandegger.com>
In-Reply-To: <4A028182.3040107@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200905181557.11766.kosmo@semihalf.com>
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>,
	Detlev Zundel <dzu@denx.de>, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Right. Furthermore, the i2c-mpc.c should be extened to support bus speed
> setting for the MPC512x, which has been merged recently (see commit id
> f2bd5efe).

I have simple question about bus speed setting support. Existing=20
implementation uses default safe speed if there is no 'clock-frequency'=20
property in i2c node. Comments in code suggest that this behaviour is left=
=20
for backward compatibility only. Should I make the 'clock-frequency'
property mandatory for a new type of I2C controller (MPC5121) ?

=2D-=20
Best Regards.
Piotr Zi=EAcik
