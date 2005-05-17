Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id AA35B679FC
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 May 2005 18:24:44 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j4H8TRll007575
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 May 2005 11:29:28 +0300 (EEST)
Message-ID: <4289A635.5000509@intracom.gr>
Date: Tue, 17 May 2005 11:07:17 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
References: <20050517081558.74BA0C1512@atlas.denx.de>
In-Reply-To: <20050517081558.74BA0C1512@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC885 - USB HCI drivers.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Wolfgang Denk wrote:
> Dear Mike,
> 
> in message <428995CB.4050301@compulab.co.il> you wrote:
> 
>>Do you know if the same is applicable to CPM2 USB controllers present 
>>for example on mpc8247?
> 
> 
> Sorry, I don't know from personal experience. But from what  I  heard
> there might be some "surprises", too.
> 
> 
>>The Freescale sales representative we work with actually says that CPM2 
>>USB host controller is working well.
> 
> 
> Of course they do. They say the same for the 850 and 823 :-(
> 
> Best regards,
> 
> Wolfgang Denk
> 

Well I have USB host drivers for both 8xx & 82xx working.

It was not a piece of cake exactly to get them to work
but they seem to work fine even under heavy traffic.

However I use them connected to a specific peripheral
so I don't know how well they fare when used as a PC
style USB host controller.

YMMV

Regards

Pantelis
