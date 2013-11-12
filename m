Return-Path: <msalter@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 0AE992C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Nov 2013 02:56:05 +1100 (EST)
Message-ID: <1384271711.24631.5.camel@deneb.redhat.com>
Subject: Re: [PATCH 00/11] Consolidate asm/fixmap.h files
From: Mark Salter <msalter@redhat.com>
To: monstr@monstr.eu
Date: Tue, 12 Nov 2013 10:55:11 -0500
In-Reply-To: <52824BBC.9020401@monstr.eu>
References: <1384262545-20875-1-git-send-email-msalter@redhat.com>
 <52824BBC.9020401@monstr.eu>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
 James Hogan <james.hogan@imgtec.com>, Russell King <linux@arm.linux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>, linux-hexagon@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Richard Kuo <rkuo@codeaurora.org>, microblaze-uclinux@itee.uq.edu.au,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-11-12 at 16:39 +0100, Michal Simek wrote:
> On 11/12/2013 02:22 PM, Mark Salter wrote:
> > 
> >  arch/arm/include/asm/fixmap.h        |  25 ++------
> >  arch/hexagon/include/asm/fixmap.h    |  40 +------------
> >  arch/metag/include/asm/fixmap.h      |  32 +----------
> >  arch/microblaze/include/asm/fixmap.h |  44 +-------------
> >  arch/mips/include/asm/fixmap.h       |  33 +----------
> >  arch/powerpc/include/asm/fixmap.h    |  44 +-------------
> >  arch/sh/include/asm/fixmap.h         |  39 +------------
> >  arch/tile/include/asm/fixmap.h       |  33 +----------
> >  arch/um/include/asm/fixmap.h         |  40 +------------
> >  arch/x86/include/asm/fixmap.h        |  59 +------------------
> >  include/asm-generic/fixmap.h         | 107 +++++++++++++++++++++++++++++++++++
> >  11 files changed, 125 insertions(+), 371 deletions(-)
> >  create mode 100644 include/asm-generic/fixmap.h
> 
> Any repo/branch with all these patches will be helpful.

https://github.com/mosalter/linux (fixmap branch)
