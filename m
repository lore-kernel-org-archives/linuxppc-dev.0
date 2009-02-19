Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2C707DDDA9
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 04:04:39 +1100 (EST)
Message-Id: <12B2E46F-9CA4-4950-B58A-D02E5F3AA079@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: sjoyeau@wanadoo.fr
In-Reply-To: <d194b8ce0902190848hb53166cj32e7d0bd65021d2e@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: Gianfar tx-babbling-errors
Date: Thu, 19 Feb 2009 11:03:50 -0600
References: <43EB80E07C42E1408726E4905FB96B04C0769D@CYBORG3.cyclone.com>
	<F122E3A2-3054-4BC9-9C06-0ADE590A8AFC@kernel.crashing.org>
	<43EB80E07C42E1408726E4905FB96B04C076B1@CYBORG3.cyclone.com>
	<6BBF4AB4-FFB0-46ED-B591-17DEC3BE547F@kernel.crashing.org>
	<43EB80E07C42E1408726E4905FB96B04C07700@CYBORG3.cyclone.com>
	<d194b8ce0902190848hb53166cj32e7d0bd65021d2e@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Scott Coulter <scott.coulter@cyclone.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 19, 2009, at 10:48 AM, sjoyeau@wanadoo.fr wrote:

> Hi Scott,
>
> Your issue may come from data setup (or corruption) instead of code  
> path: babbling error may occurs when a TSEC TX descriptor hasn't its  
> "last frame" bit set or when the data length is greated than max  
> frame length.
>
> --

Take a look at TxBD[TR] and see if its getting set ever.

- k
