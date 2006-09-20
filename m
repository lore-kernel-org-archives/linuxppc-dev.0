Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1AC0967B7F
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 07:33:02 +1000 (EST)
Subject: Re: [PATCH] Start arch/powerpc/boot code reorganization
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <A6FD3E5E-94EF-4E12-A0FB-8700F0DF8151@kernel.crashing.org>
References: <17680.30367.157642.674242@cargo.ozlabs.ibm.com>
	<20060920012042.GA28489@mag.az.mvista.com>
	<1158721828.3043.13.camel@vader.jdub.homelinux.org>
	<A6FD3E5E-94EF-4E12-A0FB-8700F0DF8151@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 21 Sep 2006 07:32:37 +1000
Message-Id: <1158787957.6002.307.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> So please comment the nastiness with a big "HACK HACK HACK" comment and
> make sure it only ever gets used on systems where nothing better is
> available, and all should be fine.

An option is to call it something like fw,address to avoid confusion and
make it somewhat clearer that it's really a firmware address useable
within the context of the firmware...

Ben.
