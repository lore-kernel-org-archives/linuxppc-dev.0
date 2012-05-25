Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5DBCBB6EE7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 May 2012 06:05:00 +1000 (EST)
Message-ID: <4FBFE5E3.6080600@windriver.com>
Date: Fri, 25 May 2012 16:04:51 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] gianfar:don't add FCB length to hard_header_len
References: <1337677248-27792-1-git-send-email-b06378@freescale.com>
 <20120522.151830.2018953337014839778.davem@davemloft.net>
 <4FBE4E02.1070306@computer.org> <1337876210.5070.4.camel@joe2Laptop>
 <20120525155820.GA25102@windriver.com> <1337975465.30100.4.camel@joe2Laptop>
In-Reply-To: <1337975465.30100.4.camel@joe2Laptop>
Content-Type: text/plain; charset="UTF-8"
Cc: netdev@vger.kernel.org, b06378@freescale.com, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>, Jan Ceuleers <jan.ceuleers@computer.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12-05-25 03:51 PM, Joe Perches wrote:
> On Fri, 2012-05-25 at 11:58 -0400, Paul Gortmaker wrote:
>> But you really shouldn't need the hardware to validate this kind of
>> patch anyways -- aside from your code flow change in the irq routine of
>> gianfar_ptp, you should have been simply able to check for object file
>> equivalence before and after your change.
> 
> No cross compiler either, and I'm lazy 'bout that...

Can't get much easier than using one of these:

http://www.kernel.org/pub/tools/crosstool/

Just untar, export PATH ARCH CROSS_COMPILE and go.

Can't get much lazier than that. Great to have around.

Paul.

> 
> cheers, Joe
> 
