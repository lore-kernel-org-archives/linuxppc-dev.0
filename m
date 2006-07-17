Return-Path: <tnt@246tNt.com>
Received: from outmx008.isp.belgacom.be (outmx008.isp.belgacom.be
	[195.238.5.235])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5946167BBA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Jul 2006 08:13:52 +1000 (EST)
Received: from outmx008.isp.belgacom.be (localhost [127.0.0.1])
	by outmx008.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k6HMDfu1008099
	for <linuxppc-embedded@ozlabs.org>; Tue, 18 Jul 2006 00:13:41 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <44BC0B9A.5010103@246tNt.com>
Date: Tue, 18 Jul 2006 00:13:46 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Using bestcomm in an external module (MPC5200B to be exact)
References: <4496b9a7.1d040e45.6737.ffff8473@mx.gmail.com>	<20060620210335.q9mgydr5ppkogsoo@webmail.bluenox.com>
	<1151710395.27137.7.camel@localhost.localdomain>
In-Reply-To: <1151710395.27137.7.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>> But anyway, it's mainly internal cleanup and adapting drivers
>> from the public version on my git tree to this newest/cleaner
>> version is a 15 min work ;)
>>     
>
> Any reason why you aren't regulary submitting those patches for upstream
> inclusion ?
>   
Yes. What's in there and not in main streams adds quite a lot to
arch/ppc ... So
MPC5200 should be adapted to arch/powerpc first and then those changes.
And since
no-one did that yet and I haven't done it yet either ... (I must admit I
had a quick look
and I didn't understand much on how to do the change ...)


    Sylvain


PS: Sorry for the lag (like 15 days...) you know email
problem/appartement change/vacation/... the usual ;)
