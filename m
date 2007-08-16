Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 27673DDE33
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 00:03:47 +1000 (EST)
In-Reply-To: <1187251702.8375.43.camel@concordia.ozlabs.ibm.com>
References: <Pine.LNX.4.64.0708151644090.15670@kivilampi-30.cs.helsinki.fi>
	<1187251702.8375.43.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fa88c3e5b4b0f896a16688a525bcd744@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Invalid semicolon after if statement
Date: Thu, 16 Aug 2007 16:03:29 +0200
To: michael@ellerman.id.au
Cc: =?ISO-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@helsinki.fi>,
	linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Thanks to the frickin compiler for warning us, not.

4.3: "warning: suggest braces around empty body in an 'if' statement"

4.1: "warning: empty body in an if-statement"

Your GCC is too old :-)


Segher
