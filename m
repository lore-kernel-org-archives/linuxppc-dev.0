Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2B83E67A72
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Mar 2005 05:46:48 +1000 (EST)
Date: Tue, 29 Mar 2005 11:46:46 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Martin Egholm Nielsen <martin@egholm-nielsen.dk>
Message-ID: <20050329194645.GA30850@gate.ebshome.net>
References: <4249ACF1.60305@egholm-nielsen.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4249ACF1.60305@egholm-nielsen.dk>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Overcommit (OOM) problem on embedded device (PPChameleon)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Mar 29, 2005 at 09:30:57PM +0200, Martin Egholm Nielsen wrote:

[snip]

> Specs:
> I'm having an embedded Linux system running on a PPC405EP (PPChameleon)
> with 64 megs of RAM, some flash, but (ofcourse) no swap space. It runs a
> 2.4.20 kernel patched with drivers for my device.
> 
> Problem:
> I have an application that is killed by the OOM (I guess) when it tries
> to "use" more memory than present on the system.
> Bolied down, memory is allocated with "sbrk" and then touch'ed (see
> test-application below).

[snip]

> However, both my desktop Linux (RH 7.3)/2.4.18-10/i386 and Linux
> (FC2)/2.6.5/i386 did what I expected:

Well, the only way to get the same results is to use the _same_ linux 
kernel version and have the _same_ hw configuration (e.g. memory 
configuration).

There were quite a few changes to VM during 2.4 lifetime; 2.6 is 
different from 2.4 in the memory management area. RH kernel is 
probably patched as hell, so who knows what VM it has.

--
Eugene
