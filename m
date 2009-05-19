Return-Path: <kosmo@semihalf.com>
Received: from semihalf.com (semihalf.com [206.130.101.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D90AADE0C8
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 17:51:51 +1000 (EST)
From: Piotr =?iso-8859-2?q?Zi=EAcik?= <kosmo@semihalf.com>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 08/12] mpc5121: Added I2C support.
Date: Tue, 19 May 2009 09:47:22 +0200
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<200905181557.11766.kosmo@semihalf.com>
	<4A1170B0.5080203@grandegger.com>
In-Reply-To: <4A1170B0.5080203@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200905190947.22972.kosmo@semihalf.com>
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

Monday 18 May 2009 16:29:04 Wolfgang Grandegger napisa=B3(a):
> > I have simple question about bus speed setting support. Existing
> > implementation uses default safe speed if there is no 'clock-frequency'
> > property in i2c node. Comments in code suggest that this behaviour is
> > left for backward compatibility only. Should I make the 'clock-frequenc=
y'
> > property mandatory for a new type of I2C controller (MPC5121) ?
>
> I don't think so, for the same backward compatibility reason as for the
> other boards. But the DTS file might be changed to use clock-frequency.

In my opinion implementing "backward compatilility" for MPC5121 is not good
idea. MPC5121 I2C support is completly new thing in mainline. Simply, there=
 is=20
no DTS with which I have to be compatible. Adding backward compatibility
with nothing may be confusing.

=2D-=20
Best Regards,
Piotr Zi=EAcik
