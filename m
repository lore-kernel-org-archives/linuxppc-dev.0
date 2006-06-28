Return-Path: <AZeffertt@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E42CC67B46
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Jun 2006 18:32:38 +1000 (EST)
Message-ID: <44A23E9A.50004@cambridgebroadband.com>
Date: Wed, 28 Jun 2006 09:32:26 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: dhlii@comcast.net, linuxppc-embedded@ozlabs.org
Subject: Re: how to get individual patches
References: <86EC6E02268B3D4BA41C1B0C61FB14E60AFCD219@mdcexc01.na.ops.local>	<20060627212448.7d048b7a@White64>
	<44A23488.7030606@dlasys.net>
In-Reply-To: <44A23488.7030606@dlasys.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

David H. Lynch Jr. wrote:
>     The bsp I am working on works with 2.6.16.21 but fails with 2.6.17.
>    
>     How can I find the individual patches that make up the transition
> from 2.6.16.21 to 2.6.17 ?
> 
>     I guess I can use interdiff to create single patch to go from
> 2.6.16.21 to 2.6.17 but I am really looking to get all the individual
> patches so I can try to isolate exactly
>     what is giving me trouble.
> 

For diffs of individual files between official kernel releases you can
use

	http://www.linuxhq.com/kernel/

It's really good!

Alex
