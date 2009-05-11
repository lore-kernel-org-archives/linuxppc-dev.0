Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id D2EC0DDF86
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 09:24:42 +1000 (EST)
Date: Mon, 11 May 2009 16:24:36 -0700 (PDT)
Message-Id: <20090511.162436.193717082.davem@davemloft.net>
To: cfriesen@nortel.com
Subject: Re: question about softirqs
From: David Miller <davem@davemloft.net>
In-Reply-To: <4A086DB2.8040703@nortel.com>
References: <18948.63755.279732.294842@cargo.ozlabs.ibm.com>
	<20090508.234815.127227651.davem@davemloft.net>
	<4A086DB2.8040703@nortel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: "Chris Friesen" <cfriesen@nortel.com>
Date: Mon, 11 May 2009 12:25:54 -0600

> David Miller wrote:
> 
>> You know, for networking over loopback (one of the only real cases
>> that even matters, if we get a hard interrupt then the return from
>> that would process any softints), we probably make out just fine
>> anyways.  As long as we hit a local_bh_enable() (and in the return
>> path from device transmit that's exceedingly likely as all of the
>> networking locking is BH safe) we'll run the softints from that and
>> thus long before we get to syscall return.
> 
> What about the issue I raised earlier?  (I don't think you were copied
> at that point.)

I'm sure all of the networking experts on linuxppc-dev will have
an answer.

And yes that was sarcasm :-)  You need to ask this on netdev or similar
list.
