Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7BF39679F0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Aug 2006 14:11:05 +1000 (EST)
In-Reply-To: <OF403D77BC.13F5C3B5-ON652571C6.003D5A1C-652571C6.003E28AE@lntinfotech.com>
References: <OF403D77BC.13F5C3B5-ON652571C6.003D5A1C-652571C6.003E28AE@lntinfotech.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E5C22C0A-45C9-4FA8-B10D-8F3EBDA03878@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Gianfar eth driver on 8540 ppc - for 2.4 and 2.6 : different
	outputs
Date: Thu, 10 Aug 2006 23:10:45 -0500
To: Prashant Yendigeri <Prashant.Yendigeri@lntinfotech.com>
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


On Aug 10, 2006, at 6:18 AM, Prashant Yendigeri wrote:

>
> Hi,
>
> The gianfar driver of 2.6.12 and 2.4.20 give different outputs on  
> the same PPC 8540 board.
>
> What could be the reason ?
>
> Output on 2.4.20 :
> /root # ifconfig eth0 172.28.8.254 up
> eth0: PHY is Marvell 88E1011S (1410c62)
> eth0: Auto-negotiation done
> eth0: Half Duplex
> eth0: Speed 10BT
> eth0: Link is up
>
> Output on 2.6.12
> / # ifconfig eth0 172.28.8.254 up
>  eth0: PHY is Generic MII (ffffffff)

It looks like your 2.6.12 kernel isn't handling the PHY correctly.   
I'd recommend upgrading to something newer which has the phylib  
(can't remember which 2.6 that went into).

- kumar
