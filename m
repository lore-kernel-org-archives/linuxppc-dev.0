Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id C2554DDE17
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 04:47:30 +1100 (EST)
Message-ID: <477BCE30.8010306@pikatech.com>
Date: Wed, 02 Jan 2008 12:47:28 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Misbah khan <misbah_khan@engineer.com>
Subject: Re: How to creat a .config file for a driver and How to use it in
	adevice driver?????
References: <14576412.post@talk.nabble.com>
In-Reply-To: <14576412.post@talk.nabble.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Misbah khan wrote:
> Hi all ...
>
> i am writing a device driver in which the default configuration for LCD
> display i need to keep it in a .config file so that as the system boots it
> take the value from this file and does the initial configuration in the init
> of the driver. If user changes the .config file content in the next boot the
> LCD driver should take the new default configuration 
>
> There will also be a run time config which could be changed at the rum time
> but will not change the default configuration.
>
>
> i am writing a LCD driver for PPC arch i need to know that how should i
> creat a .config file and How should i use it my device driver. ??????
>
> If you had an exprience in this regard please do share with me ...
>
> ----Misbah <><
>   
You don't. The safe way is to have sane defaults in the driver. Then 
write a user mode app that reads the config file and configures the 
driver properly, probably through ioctls.

Cheers,
    Sean
