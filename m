Return-Path: <CFRIESEN@nortel.com>
Received: from zrtps0kn.nortel.com (zrtps0kn.nortel.com [47.140.192.55])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 40B4DDDDE6
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 04:36:30 +1100 (EST)
Message-ID: <4905FC15.3020702@nortel.com>
Date: Mon, 27 Oct 2008 11:36:21 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] genirq: Set initial default irq affinity to just CPU0
References: <20081024.161813.193686281.davem@davemloft.net>
	<1224970389.7654.473.camel@pasglop> <4903A37A.50607@hypersurf.com>
	<20081025.210513.80339263.davem@davemloft.net>
In-Reply-To: <20081025.210513.80339263.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, kevdig@hypersurf.com
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
> Date: Sat, 25 Oct 2008 15:53:46 -0700
> 
>> What does this all mean to my GigE (dual 1.1 GHz 7455s)? Is this
>> thing supposed to be able to spread irq between its cpus?
> 
> Networking interrupts should lock onto a single CPU, unconditionally.
> That's the optimal way to handle networking interrupts, especially
> with multiqueue chips.

What about something like the Cavium Octeon, where we have 16 cores but a 
single core isn't powerful enough to keep up with a gigE device?

Chris
