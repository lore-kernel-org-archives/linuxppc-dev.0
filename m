Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 35A7D2BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Nov 2004 19:30:16 +1100 (EST)
Date: Fri, 26 Nov 2004 00:30:14 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Andriy Korud <a.korud@vector.com.pl>
Message-ID: <20041126083013.GA4609@gate.ebshome.net>
References: <1101402827.10369.8.camel@localhost>
	<20041125185233.GA13325@gate.ebshome.net>
	<1101460411.6134.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1101460411.6134.2.camel@localhost>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 440GP "Ebony" boot problems
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Nov 26, 2004 at 10:13:31AM +0100, Andriy Korud wrote:
> - make bzImage within stock 2.6.9 gives me zImage.elf

You should use arch/ppc/boot/images/zImage.ebony, not zImage.elf

Correct OpenBIOS image has "\0RPO" at the beginning.

--
Eugene
