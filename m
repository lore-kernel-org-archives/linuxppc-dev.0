Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Kt190wXDzF3Kh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 19:29:00 +1000 (AEST)
Date: Wed, 26 Sep 2018 04:28:07 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Russell Currey <ruscur@russell.cc>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] powerpc/64: add stack protector support
Message-ID: <20180926092806.GM23155@gate.crashing.org>
References: <2b934594d21ade67a4092637cf9e6b7d2d131187.1537801613.git.christophe.leroy@c-s.fr>
 <e84d65fb4744cf8260eb2fc9474765a7f3a60573.1537801613.git.christophe.leroy@c-s.fr>
 <0797fc91-6400-2508-1cc0-4bba78aafbbb@c-s.fr>
 <d203ccfce64c8f9fd403162f2fa3807ade7f1d28.camel@russell.cc>
 <30fb4e6b-0981-c53c-a1db-94138eaad268@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <30fb4e6b-0981-c53c-a1db-94138eaad268@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 26, 2018 at 09:58:30AM +0200, Christophe LEROY wrote:
> Segher, any idea about this problem ?

> >>arch/powerpc/platforms/powermac/bootx_init.o: In function `bootx_printf':
> >>/var/lib/jenkins-slave/workspace/snowpatch/snowpatch-linux-
> >>sparse/linux/arch/powerpc/platforms/powermac/bootx_init.c:88:
> >>undefined reference to `__stack_chk_fail_local'

Are you building as PIC?  Are you linking libssp_nonshared.a?  Why not?

:-)


Segher
