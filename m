Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0D976680F4
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Sep 2005 22:15:50 +1000 (EST)
Message-ID: <4316F0EE.3020001@varma-el.com>
Date: Thu, 01 Sep 2005 16:15:42 +0400
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
References: <20050831204627.EAF8C35258E@atlas.denx.de>
In-Reply-To: <20050831204627.EAF8C35258E@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sylvain Munaut <tnt@246tNt.com>, linuxppc-embedded@ozlabs.org
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



Wolfgang Denk wrote:
> Dear Andrey,
> 
> in message <4315D1DC.1000607@varma-el.com> you wrote:
> 
>>Wolfgang, first question to you:
>>May be you are know where I could find (if it exist)
>>BestComm (SmartComm) API for mystic MGT5100?
> 
> 
> We did not test the current code on the Icecube with  the  5100,  but
> previous  versions  used to run fine (well, within the limitations of
> the 5100, that is). So if the current code on our CVS server does not
> run, just check out an oder version. You can search  the  history  of
> changes for example here:
> http://source.denx.net/cgi-bin/gitweb.cgi?p=linuxppc_2_4_devel.git
> like that:
> http://source.denx.net/cgi-bin/gitweb.cgi?p=linuxppc_2_4_devel.git&a=search&s=bestcomm
No, Wolfgang, I'm sorry, but you are don't understand me.
I seek bestcomm u-code for MGT5100 (and only for 5100) exceptionally for
subj. Since in 5100 was implemented EU#1, hence bestcomm u-code
for it have a little differences (in DRD2xx, if be more precesily).
This u-code is partially presented in U-boot (eth RX/TX tasks),
but it is not enough for me.

-- 
Regards
Andrey Volkov
