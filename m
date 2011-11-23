Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7406A1007D2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2011 12:34:51 +1100 (EST)
Message-ID: <1322012084.14573.19.camel@pasglop>
Subject: Re: [PATCH] powerpc: 44x: Add mtd ndfc to the ppx44x defconfig
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@gmail.com>
Date: Wed, 23 Nov 2011 12:34:44 +1100
In-Reply-To: <CA+5PVA7js5kmK3JGDKiYa+xVqojmM2ZedifPHHWFsY7CYrqzYA@mail.gmail.com>
References: <20111122234933.GA28400@thor.bakeyournoodle.com>
 <CA+5PVA7js5kmK3JGDKiYa+xVqojmM2ZedifPHHWFsY7CYrqzYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-11-22 at 20:04 -0500, Josh Boyer wrote:
> On Tue, Nov 22, 2011 at 6:50 PM, Tony Breeds <tony@bakeyournoodle.com> wrote:
> > Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> 
> Acked-by: Josh Boyer <jwboyer@gmail.com>
> 
> Ben, I don't have anything particularly urgent for 3.2 and this seems
> like it is well within the 3.2 window (defconfig updates usually come
> later).  Want to pick this up yourself, or do you want me to prep a
> tree somewhere?

I'm working on 3.3 right now, so I'd rather you throw this in there, I
doesn't seem to be particularily urgent for 3.2 is it? (who actually
uses 4xx_defconfig ?)

Cheers,
Ben.
