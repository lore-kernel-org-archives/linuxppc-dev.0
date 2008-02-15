Return-Path: <sean.maclennan@pikatech.com>
Received: from fusion.kanatek.com (fusion.kanatek.com [207.107.229.150])
	by ozlabs.org (Postfix) with ESMTP id B4AE0DE308
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 05:40:38 +1100 (EST)
Message-ID: <47B5EA8C.5000008@pikatech.com>
Date: Fri, 15 Feb 2008 14:39:56 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: NOR flash partitions gone
References: <47B5E3CA.5050208@pikatech.com>
	<20080215181743.GA30029@localhost.localdomain>
In-Reply-To: <20080215181743.GA30029@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: 'linuxppc-dev' <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> Probably CONFIG_MTD_OF_PARTS is not set?
>
> Good luck,
>   
That was it! Thanks!

Cheers,
   Sean
