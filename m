Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E39CFDDF49
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 07:18:37 +1000 (EST)
Message-ID: <4820CB5D.3000703@freescale.com>
Date: Tue, 06 May 2008 16:19:25 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Ronald Madrid <ron_madrid@hotmail.com>
Subject: Re: ifconfig MPC8313
References: <BAY114-W949ADEBC809E7A60716CCF4D60@phx.gbl>
In-Reply-To: <BAY114-W949ADEBC809E7A60716CCF4D60@phx.gbl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ronald Madrid wrote:
> Hello all,
> 
> I am working on porting linux 2.6.25 with a custom MPC8313 based board, 
> but am having a little bit of trouble with the ethernet, more 
> specifically ifconfig.
> 
> after typing "ifconfig eth0 10.196.31.84" I receive the following error
> ifconfig: SIOCSIFFLAGS: Cannot assign requested address
> 
> after entering a MAC address via "ifconfig eth0 hw ether"  I receive 
> this error.
> e0024520:01 not found
> eth0: Could not attach to PHY
> ifconfig: SIOCSIFFLAGS: No such device

It can't find the PHY for eth0.  What does your device tree look like, 
and what is the relevant PHY address?

-Scott
