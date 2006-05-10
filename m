Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C6276679A6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 May 2006 02:43:32 +1000 (EST)
Date: Wed, 10 May 2006 09:43:29 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: dhlii@comcast.net
Subject: Re: Calculating virtual address from physical address
Message-ID: <20060510164329.GA32200@gate.ebshome.net>
References: <200605061843.k46Ih5Vd032048@www-webmail1.magma.ca>
	<4461C8BE.4050504@dlasys.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4461C8BE.4050504@dlasys.net>
Cc: Chris Dumoulin <cdumoulin@ics-ltd.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, May 10, 2006 at 07:04:30AM -0400, David H. Lynch Jr. wrote:

[skip]

>     Unless I am completely mistaken, machine checks are not cause by
> softwded are or programming errors, they are cause by hardware problems,

You can trivially trigger MachineChecks without any hardware problems 
- just map some non-existent physical address and try to access it.

-- 
Eugene
