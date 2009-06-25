Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AA941B6F56
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Jun 2009 05:35:14 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3D88EDDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jun 2009 05:35:13 +1000 (EST)
Message-ID: <4A43D15A.60806@freescale.com>
Date: Thu, 25 Jun 2009 14:34:50 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: kernel mailz <kernelmailz@googlemail.com>
Subject: Re: 85xx Address space query
References: <abe8a1fd0906240244i6e33c260xadff5cf462df7b8c@mail.gmail.com>	<D47FC871-1535-4DBF-8617-6EEA8C180484@kernel.crashing.org>	<abe8a1fd0906241046x2e3ee7d5h6a6c0231086a6f0e@mail.gmail.com>	<4A42AE1A.1090107@freescale.com>
	<abe8a1fd0906250351y1aadc153m9f52f65a5860a2ca@mail.gmail.com>
In-Reply-To: <abe8a1fd0906250351y1aadc153m9f52f65a5860a2ca@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kernel mailz wrote:
> So this means
> when kernel gets interrupted by app which may be in PID=5 (say)
> kernel translations for PID=0 remain valid ?
> I am not able to follow Scott

Yes, exactly.  They're valid even in userspace, except to the extent that the 
kernel marks them supervisor-only.

-Scott
