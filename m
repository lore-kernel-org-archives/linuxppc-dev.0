Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQBFy5CtfzDqR3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 13:52:22 +1000 (AEST)
Message-ID: <1465444342.30688.5.camel@ellerman.id.au>
Subject: Re: [PATCH 1/5] selftests/powerpc: Check for VSX preservation
 across userspace preemption
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>, Cyril Bur <cyrilbur@gmail.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, Anshuman Khandual
 <khandual@linux.vnet.ibm.com>
Date: Thu, 09 Jun 2016 13:52:22 +1000
In-Reply-To: <87mvmvqh38.fsf@possimpible.ozlabs.ibm.com>
References: <20160608040036.13064-1-cyrilbur@gmail.com>
 <20160608040036.13064-2-cyrilbur@gmail.com>
 <87mvmvqh38.fsf@possimpible.ozlabs.ibm.com>
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

On Thu, 2016-06-09 at 11:35 +1000, Daniel Axtens wrote:
> > +/*
> > + * Copyright 2015, Cyril Bur, IBM Corp.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version
> > + * 2 of the License, or (at your option) any later version.
> > + */
> I realise this is well past a lost cause by now, but isn't the idea to
> be version 2, not version 2 or later?

No.

I asked the powers that be and apparently for new code we're supposed to use v2
or later.

cheers
