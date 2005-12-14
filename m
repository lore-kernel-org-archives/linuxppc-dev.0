Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 0339268802
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Dec 2005 02:25:34 +1100 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id jBEFYJ2q004131
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Dec 2005 17:34:19 +0200 (EET)
Message-ID: <43A03821.6040206@intracom.gr>
Date: Wed, 14 Dec 2005 17:20:01 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Robin Mathew <robbinmathew@gmail.com>
References: <5b74ec4d0512140628y42986bc0h2f107e788dd115b6@mail.gmail.com>
In-Reply-To: <5b74ec4d0512140628y42986bc0h2f107e788dd115b6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 8260 ethernet driver multicast problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Robin Mathew wrote:
> Hi,
> I was encountering a problem with the receipt of multicast packets from eth
> interface in 8260 platform. The issue was traced to the fcc_enet.c driver. A
> stray return in the set_multicast_list function was the culprit.
> 
> The following is the changes that I have made-
> 
> Index: fcc_enet.c
> @@ -1488,7 +1488,6 @@
> 
>      cep = (struct fcc_enet_private *)dev->priv;
> 
> -return;
>      /* Get pointer to FCC area in parameter RAM.
>      */
>      ep = (fcc_enet_t *)dev->base_addr;
> 
> 
> Can you please tell me whether there is any issue with setting the driver in
> multicast or promiscous mode. Was this change deliberately done or is it
> really a bug?
> 
> Thanks in advance,
> Robin
> 

Robin, what's the kernel version you're using?

If you're using 2.6 there's a brand new driver you can use.

Regards

Pantelis
