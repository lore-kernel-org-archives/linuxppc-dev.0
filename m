Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 48B23679F3
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Feb 2006 05:33:33 +1100 (EST)
Date: Sun, 12 Feb 2006 10:33:30 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: "dibacco@inwind.it" <dibacco@inwind.it>
Subject: Re: system tick in PPC
Message-ID: <20060212183330.GB32060@gate.ebshome.net>
References: <IUL5ER$96FFE4CFF38D6FFE5A07D5798F74338C@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <IUL5ER$96FFE4CFF38D6FFE5A07D5798F74338C@libero.it>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, Feb 12, 2006 at 06:47:15PM +0100, dibacco@inwind.it wrote:
> Someone knows how the jiffies is incremented in PPC?
> Using PIT, Decrementer or what?

I think you should be looking at include/asm-powerpc/time.h, 
set_dec() & get_dec() functions. 

timer_interrupt() uses set_dec().

In short, usually PPC uses decrementer, but some sub-archs are special.

-- 
Eugene
