Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7BFECDDF4F
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 01:36:11 +1100 (EST)
Subject: Re: [PATCH] [POWERPC] fix up log_plpar_hcall_return
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: will_schmidt@vnet.ibm.com
In-Reply-To: <1173222701.13165.9.camel@localhost>
References: <1173222701.13165.9.camel@localhost>
Content-Type: text/plain
Date: Wed, 07 Mar 2007 15:36:05 +0100
Message-Id: <1173278165.8635.0.camel@localhost.localdomain>
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

On Tue, 2007-03-06 at 17:11 -0600, Will Schmidt wrote:
> This is mostly cosmetic.  This updates log_plpar_hcall_return() to use a
> case statement rather than an if-then-else jumble, and moves it to
> rtas.c where it can be near the other rtas related functions. 

Except that this has nothing to do with RTAS or do I miss something ?

Ben.
