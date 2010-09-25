Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8C2FAB70F2
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Sep 2010 19:45:13 +1000 (EST)
Message-ID: <4C9DC510.8010403@windriver.com>
Date: Sat, 25 Sep 2010 17:46:56 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: David Hagood <david.hagood@gmail.com>
Subject: Re: MPC8641D PEX: programming OWBAR in Endpoint mode?
References: <08f8439b89ad5771221aaba1cee86fc4.squirrel@localhost>	
	<52CF90264091A14888078A031D780F4306C8C0FF@ism-mail03.corp.ad.wrs.com>	
	<1285240268.2454.8.camel@chumley>	
	<52CF90264091A14888078A031D780F4306C8C14B@ism-mail03.corp.ad.wrs.com>	
	<409c3f6d508ece73c18f6ce750513b22.squirrel@localhost>	
	<52CF90264091A14888078A031D780F4306C8C176@ism-mail03.corp.ad.wrs.com>
	<1285325425.2454.11.camel@chumley>
In-Reply-To: <1285325425.2454.11.camel@chumley>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Hagood wrote:
> On Fri, 2010-09-24 at 07:09 +0200, Chen, Tiejun wrote:
> 
>> Right but this should be done for RC mode, not for EP mode we're
>> discussing.
>>
>> Tiejun
> 
> According to the Freescale documentation, outbound is just as valid for
> endpoint as for root complex - indeed, to generate MSIs from software

Yes.

As a summary you have no any issue to access InBound/BAR/LAW. And actually I'm
always strange that even you cannot configure InBound/BAR/LAW properly, you also
should be allowed to write OutBound REGs. And I remember there is only one
requirement to OutBound, and that is the window address should be aligned based
on the size from OWS. Are you sure?

And did you try to configure OutBound REGS when RC mode? If so I'm afraid we may
miss some errata on EP.

And do you have any response from Freescale?

Cheers
Tiejun

> REQUIRES programming an outbound ATMU to access the host's APIC.
> 
> Moreover, ANY PCI endpoint SHOULD be able to do bus master access, and
> that is done by the outbound ATMUs.
> 
> 
> 
