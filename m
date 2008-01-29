Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5B3CDDDE17
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jan 2008 10:16:02 +1100 (EST)
Message-ID: <479FB3CC.1010708@freescale.com>
Date: Tue, 29 Jan 2008 17:16:28 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: rmcguire@videopresence.com
Subject: Re: SET_NETDEV_DEV -> 83xx HDLC Driver??
References: <mailman.1.1201309203.24413.linuxppc-embedded@ozlabs.org>	<000601c85fc5$41e48330$6405a8c0@absolut>	<D71D9F25-4724-487E-AD07-E848B4608B97@freescale.com>
	<002301c862cb$54f73770$6405a8c0@absolut>
In-Reply-To: <002301c862cb$54f73770$6405a8c0@absolut>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Russell McGuire wrote:
> Andy,
> 
> /drivers/net/fec_8xx
> 
> Doesn't use the call, though I imagine it is legacy or only for older
> boards.

I don't think it's used on anything, actually.  drivers/net/fs_enet is 
the driver for 8xx fec.

-Scott
