Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 80F26B6F69
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Aug 2011 04:12:23 +1000 (EST)
Received: from mail52-va3 (localhost.localdomain [127.0.0.1])	by
	mail52-va3-R.bigfish.com (Postfix) with ESMTP id D1101E9840C	for
	<linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2011 18:12:17 +0000 (UTC)
Message-ID: <4E3C3270.2010705@freescale.com>
Date: Fri, 5 Aug 2011 13:12:00 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: <smitha.vanga@wipro.com>
Subject: Re: FW: Ethernet driver WR linux
References: <07ACDFB8ECA8EF47863A613BC01BBB220344E2AB@HYD-MKD-MBX02.wipro.com>
In-Reply-To: <07ACDFB8ECA8EF47863A613BC01BBB220344E2AB@HYD-MKD-MBX02.wipro.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/05/2011 12:31 AM, smitha.vanga@wipro.com wrote:
> Hi
>  
> I have bringup WR linux 2.6.38 on a custom mpc8247 board. Not able to
> configure the ipaddress.  When I boot my linux kernel I get the below
> message.
> Also I am using the fec 1.  The fec is not getting initialized. 
> fs_enet.c:v1.0 (Aug 8, 2005)
> BB MII Bus: Cannot register as MDIO bus
> fsl-bb-mdio: probe of fsl-bb-mdio.0 failed with error -1
> BB MII Bus: Cannot register as MDIO bus
> fsl-bb-mdio: probe of fsl-bb-mdio.1 failed with error -1
> I have enabled the following:
>  
> 
> CONFIG_NET_ETHERNET=y
> 
> CONFIG_MII=y
> 
> CONFIG_FS_ENET=y
> 
> # CONFIG_FS_ENET_HAS_SCC is not set
> 
> CONFIG_FS_ENET_HAS_FCC=y

Can you attach your device tree?  What sort of mdio do you have on your
board?

> *Please do not print this email unless it is absolutely necessary. *
> 
> The information contained in this electronic message and any attachments
> to this message are intended for the exclusive use of the addressee(s)
> and may contain proprietary, confidential or privileged information. If
> you are not the intended recipient, you should not disseminate,
> distribute or copy this e-mail. Please notify the sender immediately and
> destroy all copies of this message and any attachments.
> 
> WARNING: Computer viruses can be transmitted via email. The recipient
> should check this email and any attachments for the presence of viruses.
> The company accepts no liability for any damage caused by any virus
> transmitted by this email.
> 
> www.wipro.com

Is there any way you can turn this crud off?

-Scott
