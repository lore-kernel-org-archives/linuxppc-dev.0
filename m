Return-Path: <CFRIESEN@nortel.com>
Received: from zcars04f.nortel.com (zcars04f.nortel.com [47.129.242.57])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0CBB1DDE19
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 04:49:53 +1100 (EST)
Message-ID: <48FF6797.2030909@nortel.com>
Date: Wed, 22 Oct 2008 11:49:11 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: build failure on powerpc with current -git
References: <48F8E86B.702@nortel.com>
	<18685.27030.529655.761257@cargo.ozlabs.ibm.com>
	<20081021191324.d4810d40.sfr@canb.auug.org.au>
	<18686.42209.47915.184451@cargo.ozlabs.ibm.com>
In-Reply-To: <18686.42209.47915.184451@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:

> Chris, could you try just the following change (my previous patch
> without the arch/powerpc/boot/wrapper change) and let me know if it
> fixes things with the ld you use?

The build completes with no errors.  Haven't actually booted it though.

Gets my vote...

Chris
