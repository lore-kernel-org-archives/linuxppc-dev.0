Return-Path: <matt@ozlabs.org>
Message-ID: <4E24DC18.7050007@ozlabs.org>
Date: Tue, 19 Jul 2011 11:21:28 +1000
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net: filter: BPF 'JIT' compiler for PPC64
References: <4E23E5C3.1070209@ozlabs.org>	<1310978375.5756.7.camel@edumazet-HP-Compaq-6005-Pro-SFF-PC>
	<20110718.124248.1462465498024218250.davem@davemloft.net>
In-Reply-To: <20110718.124248.1462465498024218250.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	eric.dumazet@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19/07/11 05:42, David Miller wrote:
> From: Eric Dumazet <eric.dumazet@gmail.com>
> Date: Mon, 18 Jul 2011 10:39:35 +0200
> 
>> So in PPC SEEN_XREG only is to be set of X is read, not if written.
>>
>> So you dont have to set SEEN_XREG bit in this part :
> 
> Matt, do you want to integrate changes based upon Eric's feedback
> here or do you want me to apply your patch as-is for now?

Thanks, but no worries; I will send a v2 in a sec.  Eric's comments are spot-on,
and there are a couple of other areas that the brainfart should really be
polished out of, too.  :-)


Cheers,


Matt
