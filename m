Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id ADCD2DDE03
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Apr 2008 11:51:46 +1000 (EST)
Received: from [192.168.1.37] (node60.78.251.72.1dial.com [72.251.78.60])
	(authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id m3R1pLcs044258
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Apr 2008 18:51:41 -0700 (PDT)
Message-ID: <4813E74B.1020506@hypersurf.com>
Date: Sat, 26 Apr 2008 19:39:07 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: get_cycles()
References: <4812DFA3.6090106@hypersurf.com>
	<20080426.001102.65527296.davem@davemloft.net>
In-Reply-To: <20080426.001102.65527296.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Miller wrote:
> From: Kevin Diggs <kevdig@hypersurf.com>
> Date: Sat, 26 Apr 2008 00:54:11 -0700
> 
> 
>>	Anyone know how to turn get_cycles() into an actual time in a module? 
>>ppc_tb_freq does not seem to be exported?
> 
> 
> You should really be using ktime_t and associated interfaces.
> 
This looks pretty cool ... but I don't want to create a dependency on
hrtimer.

So ... How expensive would it be to export ppc_tb_freq? Or add a
get_cycles_tb() function?

kevin
