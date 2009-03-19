Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 41B7ADDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 03:28:11 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by protonic.prtnl (Postfix) with ESMTP id 6330429ECA
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 17:26:50 +0100 (CET)
Received: from protonic.prtnl ([127.0.0.1])
	by localhost (protonic [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 18243-07 for <linuxppc-dev@ozlabs.org>;
	Thu, 19 Mar 2009 17:26:50 +0100 (CET)
Received: from archvile.prtnl (archvile.prtnl [192.168.1.153])
	by protonic.prtnl (Postfix) with ESMTP id 2102929EBA
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 17:26:50 +0100 (CET)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-dev@ozlabs.org
Subject: Re: Issue with UART driver on MPC5121e Platform
Date: Thu, 19 Mar 2009 17:28:31 +0100
References: <F7846B8F3C78C049B6A1DFF861F6C16F0353EB9A@kcinblrexb01.kpit.com>
In-Reply-To: <F7846B8F3C78C049B6A1DFF861F6C16F0353EB9A@kcinblrexb01.kpit.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200903191728.31481.david.jander@protonic.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 19 March 2009 05:23:07 Madhusudhan J wrote:
>  Hi,
>
> this is Madhusudhan J from KPITCummins Bangalore India .
> I have issue with uart driver   in linux kernel 2.6.24
> (drivers\serial\Mpc52xx_uart.c)
> I am using platform  mpc5121e to communicating to modem through serial
> driver. i am not able to communicate with  UART
> driver(drivers\serial\Mpc52xx_uart.c).
> In this file i could not see 512x uart operations but UART opration are
> there for 52xx. could you please let me know how to make it work with
> uart driver on 5121e platform?.

Can you tell more about which kernel you are using?

Please use the lates git head called "ads5121" from denx.
I am using that one, and the UART works fine.
There are although a lot of tricky details in your device-tree that have to
be correct in order for this driver to work.
Are you using you own hardware, or are you using the ADS5121?
What version of the MPC5121e processor do you have? M34K, 2M34K or M36P?

Regards,

-- 
David Jander
Protonic Holland.
