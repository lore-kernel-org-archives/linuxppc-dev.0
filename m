Return-Path: <a.korud@vector.com.pl>
Received: from lion.vector.com.pl (lion.vector.com.pl [81.210.9.36])
	by ozlabs.org (Postfix) with ESMTP id A2BB92BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Nov 2004 20:33:57 +1100 (EST)
From: Andriy Korud <a.korud@vector.com.pl>
To: Eugene Surovegin <ebs@ebshome.net>
In-Reply-To: <20041126083013.GA4609@gate.ebshome.net>
References: <1101402827.10369.8.camel@localhost>
	<20041125185233.GA13325@gate.ebshome.net>
	<1101460411.6134.2.camel@localhost>
	<20041126083013.GA4609@gate.ebshome.net>
Content-Type: text/plain
Date: Fri, 26 Nov 2004 11:28:50 +0100
Message-Id: <1101464930.6134.5.camel@localhost>
Mime-Version: 1.0
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

Thanks,
the problem was buggy OpenBIOS v 1.18 (problems with EMAC).
After upgrading to 1.19 everything works fine.

thanks,

--

Andriy Korud

On Fri, 2004-11-26 at 00:30 -0800, Eugene Surovegin wrote:
> On Fri, Nov 26, 2004 at 10:13:31AM +0100, Andriy Korud wrote:
> > - make bzImage within stock 2.6.9 gives me zImage.elf
> 
> You should use arch/ppc/boot/images/zImage.ebony, not zImage.elf
> 
> Correct OpenBIOS image has "\0RPO" at the beginning.
> 
> --
> Eugene
> 
