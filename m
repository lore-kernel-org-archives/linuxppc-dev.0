Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 06613DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 03:31:08 +1100 (EST)
Message-Id: <A543F487-78F9-4791-ABEB-2D8D017A516B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Coulter <scott.coulter@cyclone.com>
In-Reply-To: <43EB80E07C42E1408726E4905FB96B04C07700@CYBORG3.cyclone.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: Gianfar tx-babbling-errors
Date: Thu, 19 Feb 2009 10:29:52 -0600
References: <43EB80E07C42E1408726E4905FB96B04C0769D@CYBORG3.cyclone.com>
	<F122E3A2-3054-4BC9-9C06-0ADE590A8AFC@kernel.crashing.org>
	<43EB80E07C42E1408726E4905FB96B04C076B1@CYBORG3.cyclone.com>
	<6BBF4AB4-FFB0-46ED-B591-17DEC3BE547F@kernel.crashing.org>
	<43EB80E07C42E1408726E4905FB96B04C07700@CYBORG3.cyclone.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 19, 2009, at 10:17 AM, Scott Coulter wrote:

>
>
> Kumar,
>
>>
>> can't think of any.  How about adding a BUG_ON() in the tx path to  
>> see
>> if the buffer size > MTU and re-run your tests.
>>
>
> So, here are the checks I've tried in gfar_start_xmit():
>
> BUG_ON(skb->len > DEFAULT_RX_BUFFER_SIZE)
>
> BUG_ON(skb->len > priv->regs->maxfrm)
>
> Neither produces a bug check yet ethtool reports non-zero
> tx-babbling-errors.  The last check appears to be the definition of
> tx-babbling-errors.  Is there a transmit path that I have missed?

What specific processor & rev are you running on?

- k
