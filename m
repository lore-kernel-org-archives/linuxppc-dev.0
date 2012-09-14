Return-Path: <michael@ellerman.id.au>
Received: from [10.61.2.158] (ibmaus65.lnk.telstra.net [165.228.126.9])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPSA id 9186D2C0086
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2012 18:59:13 +1000 (EST)
Message-ID: <1347613154.3142.10.camel@concordia>
Subject: Re: [PATCH] powerpc: Add an xmon command to dump one or all pacas
From: Michael Ellerman <michael@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Date: Fri, 14 Sep 2012 18:59:14 +1000
In-Reply-To: <1347602637-18683-1-git-send-email-michael@ellerman.id.au>
References: <1347602637-18683-1-git-send-email-michael@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-09-14 at 16:03 +1000, Michael Ellerman wrote:
> This was originally motivated by a desire to see the mapping between
> logical and hardware cpu numbers.

Thanks to everyone who reminded me that the paca is 64-bit only :)

New patch on the way.

cheers
