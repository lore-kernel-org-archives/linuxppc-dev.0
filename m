Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B1E53B6FBB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2012 06:21:44 +1000 (EST)
Message-ID: <1335212491.21619.23.camel@pasglop>
Subject: RE: pci node question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yoder Stuart-B08248 <B08248@freescale.com>
Date: Tue, 24 Apr 2012 06:21:31 +1000
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E150334747D@039-SN1MPN1-002.039d.mgd.msft.net>
References: <9F6FE96B71CF29479FF1CDC8046E1503346013@039-SN1MPN1-002.039d.mgd.msft.net>
 <D04C6167-5286-4675-A6D8-32BA63305424@kernel.crashing.org>
 <1334956286.3197.16.camel@pasglop>
 <9F6FE96B71CF29479FF1CDC8046E150334747D@039-SN1MPN1-002.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-04-23 at 15:48 +0000, Yoder Stuart-B08248 wrote:
> Hmmm... I vaguely understand what you are saying.   But why is the
> length zero, that is what doesn't make sense on the surface?

Ah indeed, on would think that we could represent the real size of the
config space there... but I've always seen this as 0 in real OF
implementations as well, at least the G5 device-tree I'm looking at now
has it that way.

> We really should put a comment on that reg property-- can you suggest
> a short comment that would capture what the reg with all zeros 
> is for?  ...I'll submit a patch. 

Hrm.. "config address of the device: 0,0,0" ?

Cheers,
Ben.
