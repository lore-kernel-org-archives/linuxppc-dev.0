Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D4EE3B6FC4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2012 16:59:13 +1000 (EST)
Message-ID: <1334732346.1159.5.camel@pasglop>
Subject: Re: PowerPC radeon KMS - is it possible?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: o jordan <ojordan12345@hotmail.co.uk>
Date: Wed, 18 Apr 2012 16:59:06 +1000
In-Reply-To: <BAY163-W54EBB2437ED2068EF5AF5D03F0@phx.gbl>
References: <BAY163-W54EBB2437ED2068EF5AF5D03F0@phx.gbl>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-04-17 at 20:49 +0100, o jordan wrote:
> Hi list,
> 
> 
> Firstly let me say thanks for the great work you do!!!
> 
> 
> I've been trying to get Kernel Mode Setting working on my iBook with
> Ubuntu 12.04.  I can only get it working by forcing PCI mode
> (agpmode=-1).  Setting agpmode=1 or a higher number just results in
> freezing and a flashing screen.  Does anybody know how to get it
> working fully with agp?
> 

Note also that KMS doesn't afaik have the power management code that
radeonfb has for those old Mac chipsets, so suspend/resume won't work.

Cheers,
Ben.
