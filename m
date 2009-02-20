Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DC215DE16D
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Feb 2009 07:45:24 +1100 (EST)
Message-Id: <99303DA2-4BC6-4DC1-8CCE-D9BC49FCCE3F@kernel.crashing.org>
From: Becky Bruce <beckyb@kernel.crashing.org>
To: Benjamin Krill <ben@codiert.org>
In-Reply-To: <20090219220835.GI12204@codiert.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 3/3] powerpc: expect all devices calling dma ops to have
	archdata set
Date: Fri, 20 Feb 2009 14:45:04 -0600
References: <1235076557-24464-1-git-send-email-galak@kernel.crashing.org>
	<1235076557-24464-2-git-send-email-galak@kernel.crashing.org>
	<1235076557-24464-3-git-send-email-galak@kernel.crashing.org>
	<20090219220835.GI12204@codiert.org>
Cc: linuxppc-dev@ozlabs.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 19, 2009, at 4:08 PM, Benjamin Krill wrote:

> * Kumar Gala | 2009-02-19 14:49:17 [-0600]:
>
>> Now that we set archdata for of_platform and platform devices via
>> platform_notify() we no longer need to special case having a NULL  
>> device
>> pointer or NULL archdata.  It should be a driver error if this  
>> condition
>> shows up and the driver should be fixed.
>>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>
> Acked-by: Benjamin Krill <ben@codiert.org>

Tested on ppc 86xx, looks good.

Acked-by: Becky Bruce <beckyb@kernel.crashing.org>

-B
