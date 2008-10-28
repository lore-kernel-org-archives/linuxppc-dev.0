Return-Path: <CFRIESEN@nortel.com>
Received: from zrtps0kn.nortel.com (zrtps0kn.nortel.com [47.140.192.55])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id C5327DDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 10:00:35 +1100 (EST)
Message-ID: <49079969.3090100@nortel.com>
Date: Tue, 28 Oct 2008 16:59:53 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: [BUG] oops in net_rx_action on 64-bit powerpc
References: <4902B1D8.8070800@nortel.com>	<20081025.001703.261277154.davem@davemloft.net>	<49065942.4040300@nortel.com>
	<20081028.155128.144329082.davem@davemloft.net>
In-Reply-To: <20081028.155128.144329082.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, jesse.brandeburg@intel.com,
	romieu@fr.zoreil.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Miller wrote:
> From: "Chris Friesen" <cfriesen@nortel.com>
> Date: Mon, 27 Oct 2008 18:13:54 -0600
> 
> 
>>[PATCH] fix amd8111e rx return code
>>
>>The amd8111e rx poll routine currently mishandles the case when we process
>>exactly the number of packets specified in the budget.
>>
>>This patch is basically as suggested by David Miller.
>>
>>Signed-off-by: Chris Friesen <cfriesen@nortel.com>
> 
> 
> I had to apply this by hand because your email client heavily
> corrupted the patch.

Crap.  Sorry about that, it looks like I forgot to set my line-wrap to 0 
before creating the email.  @#$#% Thunderbird.

Chris
