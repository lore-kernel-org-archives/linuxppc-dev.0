Return-Path: <tnt@246tNt.com>
Received: from outmx015.isp.belgacom.be (outmx015.isp.belgacom.be
	[195.238.4.87])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3CF7F68A31
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Feb 2006 11:19:00 +1100 (EST)
Received: from outmx015.isp.belgacom.be (localhost [127.0.0.1])
	by outmx015.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id k130IsV3009963
	for <linuxppc-embedded@ozlabs.org>; Fri, 3 Feb 2006 01:18:54 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <43E2A190.4000409@246tNt.com>
Date: Fri, 03 Feb 2006 01:19:28 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Dale Farnsworth <dale@farnsworth.org>, linuxppc-embedded@ozlabs.org,
	jrigby@freescale.com
Subject: Re: [PATCH] Add fec support for mpc52xx
References: <20060202193734.22145.qmail@farnsworth.org>
In-Reply-To: <20060202193734.22145.qmail@farnsworth.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dale Farnsworth wrote:
> In article <43E24DA6.9@freescale.com> John Rigby wrote:
> 
>>Adds fec support, requires bestcom patch.  Applies to Sylvains git tree.
> 
> 
> Hmm, I thought that fec support was already in Sylvain's git tree.
> 
> I'm sure Sylvain intended it to be there.

Yup, after the recent updates that went upstream, I re-created more
cleanly my git tree. To keep it clean, I took my time to try out several
git feature and stuff before publishing result. For now the bcomm is
available as a patch and I posted the URL recently.

The splitted vesion should be uploaded tomorrow, I'll make sure I use
the latest microcode (compare with the one sent by John) but It's
getting late here.

If you don't get up too early, it should be done by the time you get up ;)


Sylvain

> 
> From http://ozlabs.org/pipermail/linuxppc-embedded/2005-June/018887.html:
> 
>>Date: Sun, 19 Jun 2005 00:15:32 +0200
>>From: Sylvain Munaut <tnt@246tNt.com>
>>
>>Following the obvious demand for it :
>>
>>rsync://gitbits.246tNt.com/gitbits/linux-2.6-mpc52xx.git
>>http://gitbits.246tNt.com/gitweb.cgi?p=linux-2.6-mpc52xx.git;a=summary
>>
>>Hopefully the server is setup correctly ...
>>It's not _heavily_ tested but it seems to works fine in the few test I
>>made.
>>
>>What in there :
>> - I2C patches that are already sent upstream but not yet in Linus tree
>> - Change of the mpc52xx uart device name and device ids to a range in
>>   the low density serial port major. Also it's now named ttyPSC? so
>>   you need to update you kernel command line (else you won't see any
>>   console). Note that the ids and names choosed are NOT YET OFFICIAL,
>>   I just included it in this release because some people were seeing
>>   conflict with the other ids. So the name and ids may change ...
>> - Some other patches that will soon be sent upstream, just waiting
>>   for you to test see if it has any negative impact.
>> - FEC and BestComm rewrite from Dale, with some improvement. For eg,
>>   the FEC task now handle misaligment so the manual alignment code
>>   has been removed, ...
> 
> 
> I hope Sylvain can resurrect the 2.6 FEC code that he, I and others
> worked on.
> 
> -Dale
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
