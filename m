Return-Path: <andrewm@isoar.ca>
Received: from mail.isoar.ca (andrewm.dsl.istop.com [66.11.173.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.isoar.ca", Issuer "Andrew E. Mileski" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 12D1567B61
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Dec 2006 11:13:42 +1100 (EST)
Received: from [10.0.1.119] (static-209-87-231-114.storm.ca [209.87.231.114])
	(authenticated bits=0)
	by mail.isoar.ca (8.12.8/8.12.8) with ESMTP id kBENJf6G029626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-embedded@ozlabs.org>; Thu, 14 Dec 2006 18:19:43 -0500
Message-ID: <4581DC0D.4030506@isoar.ca>
Date: Thu, 14 Dec 2006 18:19:41 -0500
From: "Andrew E. Mileski" <andrewm@isoar.ca>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: Floating Point Operation in Kernel
References: <426172.37473.qm@web53101.mail.yahoo.com>
In-Reply-To: <426172.37473.qm@web53101.mail.yahoo.com>
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

jimmy liu wrote:
> I am writing a module which need be integrated to the
> linux kernel with floating point operations for
> mpc82xx. The kernel does not provide support for
> floating point operations. Does anybody have good idea
> to implement it or make it to work around?

How about my fixed point routines.  They use S31.32 fixed format, which
is often better precision than using floats, though it has less range.
Awkward to use, but handy when you absolutely need to.

I originally wrote it for MP3 decoding on ARM, but it should be
portable to anything supporting "signed long long" format (hence
the name).  http://cvs.isoar.ca/math-sll/

--
Andrew E. Mileski
