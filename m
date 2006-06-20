Return-Path: <linuxppc-dev@tonarchiv.ch>
Received: from hosting.substring.ch (hosting.substring.ch [80.242.134.171])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7C6E967B34
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 23:27:55 +1000 (EST)
Message-ID: <4497F7D4.7080603@tonarchiv.ch>
Date: Tue, 20 Jun 2006 15:27:48 +0200
From: Till Wimmer <linuxppc-dev@tonarchiv.ch>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: L3 cache on Apple dual processor (7450 r 2.1) question
References: <1150726624.4711.16.camel@localhost.localdomain>
	<20060619143607.GB4845@pb15.lixom.net>
In-Reply-To: <20060619143607.GB4845@pb15.lixom.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:

>On Mon, Jun 19, 2006 at 04:17:04PM +0200, Till Wimmer wrote:
>
>  
>
>>Now my questions are:
>>Is there anything else to do for getting the L3 cache working?
>>How can i check if the L3 is enabled? E.g. is there a benchmark program
>>which accounts for cache settings?
>>    
>>
>
>lmbench has testcases for memory latency testing.
>  
>
Thank you for the hint, i tested it and the results are deflating:
Most values are the same, but the communication bandwidths are worse 
with the L3 cache enabled? Therefore i think that my L3CR settings are 
wrong.

bg
Till


-- 
********************************************************
*        "Deutschland vor!" - Die WM Gegenhymne        *
*  http://www.zittrige-haende.com/download/antiwm.mp3  *
********************************************************
