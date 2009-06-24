Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7C1F9B70CA
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Jun 2009 08:51:56 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 13C4DDDD0C
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2009 08:51:54 +1000 (EST)
Message-ID: <4A42AE1A.1090107@freescale.com>
Date: Wed, 24 Jun 2009 17:52:10 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: kernel mailz <kernelmailz@googlemail.com>
Subject: Re: 85xx Address space query
References: <abe8a1fd0906240244i6e33c260xadff5cf462df7b8c@mail.gmail.com>	<D47FC871-1535-4DBF-8617-6EEA8C180484@kernel.crashing.org>
	<abe8a1fd0906241046x2e3ee7d5h6a6c0231086a6f0e@mail.gmail.com>
In-Reply-To: <abe8a1fd0906241046x2e3ee7d5h6a6c0231086a6f0e@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
> But If the app was running with PID=1, interrupt occurs, kernel code
> gets executed in PID=1, how does the kernel handle this ? and goes
> back to PID=0, since its translations are all in PID=0

PID 0 is special, it's mappings are present regardless of the value of 
the PID register.

-Scott
