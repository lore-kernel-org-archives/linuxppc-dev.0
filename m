Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id ECEAB67A33
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 May 2005 03:08:12 +1000 (EST)
Date: Fri, 6 May 2005 10:08:09 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Message-ID: <20050506170809.GC19401@gate.ebshome.net>
References: <427B22A0.8010704@ru.mvista.com>
	<20050506081805.GA19401@gate.ebshome.net>
	<427B3465.1070502@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <427B3465.1070502@ru.mvista.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFC][PATCH 2.6.12-rc2] Updated platform additions for 82xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, May 06, 2005 at 01:09:57PM +0400, Vitaly Bordug wrote:
> PHY_INTERRUPT is defined in the board-specific platforms/pq2ads.h 
> (likewise approach was used in 2.4). Others from this define crowd 
> should reside as they are IMHO, until we have some common board-specific 
> header for 82xx (or all these will be scattered along different 82xx 
> platform defines such as tqm8260.h etc. which is even worse).  What do 
> you think?

Yeah, it's better, I'm only wondering what if some board has separate 
PHY interrupt lines for each FCC? Define name - "PHY_INTERRUPT" was 
chosen quite badly IMHO :).

-- 
Eugene
