Return-Path: <lebon@lebon.org.ua>
Received: from b-mail.com.ua (b-mail.com.ua [195.68.202.242])
	by ozlabs.org (Postfix) with ESMTP id 02DA1DE18B
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 19:23:41 +1100 (EST)
Message-ID: <49B77545.6030707@lebon.org.ua>
Date: Wed, 11 Mar 2009 10:24:37 +0200
From: Mikhail Zolotaryov <lebon@lebon.org.ua>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] PowerPC 440EPx/GRx fix memory size calculation
References: <20090310195013.GA27835@ru.mvista.com>	
	<49B6D427.5050600@lebon.org.ua> <49B7167C.9000004@ru.mvista.com>
	<1236738411.7086.38.camel@pasglop>
In-Reply-To: <1236738411.7086.38.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>> The problem is that the controller is hardwired to use only one 
>> chipselect, even if both are enabled in the DDR0_10 on PPC440EPx/GRx 
>> processors
>
> Mikhail, can you verify that Valentine's patch works for you ?

Ben, unfortunately on my board(s) I don't have both bits enabled in 
DDR0_10 i.e. I'll have cs=1 calculated even by original Linux code.
