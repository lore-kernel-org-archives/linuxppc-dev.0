Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3D255DE0E6
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 03:13:31 +1100 (EST)
In-Reply-To: <20061219041254.GB6993@stusta.de>
References: <20061124234935.GJ28363@stusta.de>
	<20061219041254.GB6993@stusta.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3B7827F6-D6CA-481F-B6DE-0F0B2AB4F632@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [2.6 patch] powerpc: remove the broken Gemini support
Date: Tue, 19 Dec 2006 10:13:29 -0600
To: Adrian Bunk <bunk@stusta.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
	Kumar Gala <galak@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 18, 2006, at 10:12 PM, Adrian Bunk wrote:

> On Sat, Nov 25, 2006 at 12:49:35AM +0100, Adrian Bunk wrote:
>> I just saw the commit message below.
>>
>> There seems to have been some although unmerged work on APUS  
>> support by
>> Roman, but I didn't find any recent work on bringing the GEMINI  
>> support
>> back into life.
>>
>> Is this a wrong impression, or would a patch to remove it be OK?
>> ...
>
> Zero feedback, patch to remove it below.
>
> cu
> Adrian

I'm good with removing GEMINI since no one seems to have raised any  
fuss about this and I brought the issue up over a year ago now.   
However, I leave the final decision up to Paul.

Also, where do we stand with APUS?

- k
