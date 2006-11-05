Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 3A7D867CB0
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Nov 2006 08:06:50 +1100 (EST)
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 957C69A5C3
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  5 Nov 2006 21:49:42 +0100 (CET)
Received: from [172.16.0.100] (p5497CDBD.dip.t-dialin.net [84.151.205.189])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 7758391ECF
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  5 Nov 2006 21:49:42 +0100 (CET)
Message-ID: <454E4E7D.7090507@grandegger.com>
Date: Sun, 05 Nov 2006 21:50:05 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: Has anyone 2.6 kernel with Xenomai and MPC5200 Lite running?
References: <20061104163119.GC69112@server.idefix.loc>	<528646bc0611041832j327c8391i9d3401782529073d@mail.gmail.com>	<20061105102328.GH79990@server.idefix.loc>	<454DBE2C.6040506@246tNt.com>
	<20061105202435.GB30026@server.idefix.loc>
In-Reply-To: <20061105202435.GB30026@server.idefix.loc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Matthias Fechner wrote:
> Hello Sylvain,
> 
> * Sylvain Munaut <tnt@246tNt.com> [05-11-06 11:34]:
>> Take the patchs off that link (bestcomm branch), and apply them on a
>> fresh/recent
>> tree, that should work. (that is, clone a official tree, then pull from
>> the above link
>> and merge the two).
>>
>> There is work in progress for the arch/powerpc port but it's not done yet.
> 
> thx a lot, I will try it tomorrow.

I also tried to get Sylvain's patches working on 2.6.18 and gave up 
rather frustrated. They do not work "as is" :-(. I can offer you a 
solution for Xenomai on 2.6.17, if this is an option for you. That's 
what I got working for development.

Wolfgang.
