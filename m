Return-Path: <tnt@246tNt.com>
Received: from outmx020.isp.belgacom.be (outmx020.isp.belgacom.be
	[195.238.2.201])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C9F5F6815F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Sep 2005 00:23:48 +1000 (EST)
Received: from outmx020.isp.belgacom.be (localhost [127.0.0.1])
	by outmx020.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j81ENgts010481
	for <linuxppc-embedded@ozlabs.org>; Thu, 1 Sep 2005 16:23:42 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <43170F55.3060505@246tNt.com>
Date: Thu, 01 Sep 2005 16:25:25 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Andrey Volkov <avolkov@varma-el.com>
References: <20050831204627.EAF8C35258E@atlas.denx.de>
	<4316F0EE.3020001@varma-el.com>
In-Reply-To: <4316F0EE.3020001@varma-el.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [RFC] MPC5200 BestComm microcode [en]/[de]coding draft
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrey Volkov wrote:
> 
> Wolfgang Denk wrote:
> 
>>Dear Andrey,
>>
>>in message <4315D1DC.1000607@varma-el.com> you wrote:
>>
>>
>>>Wolfgang, first question to you:
>>>May be you are know where I could find (if it exist)
>>>BestComm (SmartComm) API for mystic MGT5100?
>>
>>
>>We did not test the current code on the Icecube with  the  5100,  but
>>previous  versions  used to run fine (well, within the limitations of
>>the 5100, that is). So if the current code on our CVS server does not
>>run, just check out an oder version. You can search  the  history  of
>>changes for example here:
>>http://source.denx.net/cgi-bin/gitweb.cgi?p=linuxppc_2_4_devel.git
>>like that:
>>http://source.denx.net/cgi-bin/gitweb.cgi?p=linuxppc_2_4_devel.git&a=search&s=bestcomm
> 
> No, Wolfgang, I'm sorry, but you are don't understand me.
> I seek bestcomm u-code for MGT5100 (and only for 5100) exceptionally for
> subj. Since in 5100 was implemented EU#1, hence bestcomm u-code
> for it have a little differences (in DRD2xx, if be more precesily).
> This u-code is partially presented in U-boot (eth RX/TX tasks),
> but it is not enough for me.
> 

Do you have a MGT5100 ?

Frankly I'm not sure it's of much interest since even Freescale is
not seeking to have linux on 5100 and I'm not even sure you can buy some ...


	Sylvain
