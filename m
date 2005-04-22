Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id DF51F67A33
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 10:48:38 +1000 (EST)
Date: Thu, 21 Apr 2005 17:48:33 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Shawn Jin <shawnxjin@gmail.com>
Message-ID: <20050422004833.GB20046@gate.ebshome.net>
References: <c3d0340b05042117321cd86686@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c3d0340b05042117321cd86686@mail.gmail.com>
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: TODC on ppc440
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Apr 21, 2005 at 05:32:43PM -0700, Shawn Jin wrote:
> Our SoC using ppc440 core will run on an emulator first. It doesn't
> have an external RTC. Hence time_init, set_rtc_time, get_rtc_time of
> ppc_md are all set to NULL. No TODC_ALLOC() is defined.
> 
> I'm wondering if todc is vital to make OS run correctly. Is there any
> other choice?

No, RTC isn't required for Linux to run, but usually is useful to 
have.

-- 
Eugene
