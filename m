Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id D4036DDEF3
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Dec 2008 17:51:24 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LDvgH-0005AF-95
	for linuxppc-dev@ozlabs.org; Fri, 19 Dec 2008 22:51:21 -0800
Message-ID: <21102440.post@talk.nabble.com>
Date: Fri, 19 Dec 2008 22:51:21 -0800 (PST)
From: Felix Radensky <felix@embedded-sol.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Long boot delay on 460EX with 2.6.28-rc8
In-Reply-To: <20081220003704.26bfb042@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <21070179.post@talk.nabble.com>
	<20081218190208.GC18201@yoda.jdub.homelinux.org>
	<21087072.post@talk.nabble.com> <200812190856.19482.sr@denx.de>
	<494C10EE.1040305@embedded-sol.com>
	<20081220003704.26bfb042@lappy.seanm.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>




Sean MacLennan-2 wrote:
> 
> On Fri, 19 Dec 2008 23:23:58 +0200
> "Felix Radensky" <felix@embedded-sol.com> wrote:
> 
>> Hi, Sean
>> 
>> Do you have any ideas what can cause such delay ?
> 
> Sorry, I haven't been following this thread :(
> 
> We also use a 256M NAND, although a Spansion S29GL. While there is a
> small delay in u-boot, there is no noticeable during the ndfc startup.
> 
> Can you read and write the NAND properly in u-boot? That is always the
> first step. If that works, we can look at what might be different
> between the u-boot and the ndfc driver.
> 
> Cheers,
>    Sean
> 
> 

Thanks, Sean

I've found the cause of the delay. It was a stupid error on my part, not
related to ndfc driver, which is fine. Thanks a lot for you work on this.

I apologize for the noise.

Felix.
-- 
View this message in context: http://www.nabble.com/Long-boot-delay-on-460EX-with-2.6.28-rc8-tp21070179p21102440.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
