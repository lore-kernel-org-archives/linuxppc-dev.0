Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3E8E2DDEE2
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 00:28:26 +1000 (EST)
Message-Id: <394A6D0B-6A34-4973-BF14-66961724FC48@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Peter Korsgaard <jacmet@sunsite.dk>
In-Reply-To: <20080923123716.GA30625@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH v4] powerpc: gpio driver for mpc8349/8572/8610 and
	compatible
Date: Tue, 23 Sep 2008 09:28:22 -0500
References: <1222095582-19918-1-git-send-email-jacmet@sunsite.dk>
	<20080923123716.GA30625@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 23, 2008, at 7:37 AM, Anton Vorontsov wrote:

> On Mon, Sep 22, 2008 at 04:59:42PM +0200, Peter Korsgaard wrote:
>> Structured similar to the existing QE GPIO support.
>>
>> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
>
> Acked-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Peter, can you respin.  Doesn't seem to apply cleanly to latest  
powerpc-next since paulus merged in things.

- k
