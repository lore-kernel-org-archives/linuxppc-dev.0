Return-Path: <olaf@ibook.aepfle.de>
Received: from natlemon.rzone.de (natlemon.rzone.de [81.169.145.170])
	by ozlabs.org (Postfix) with ESMTP id E627667A3E
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 01:52:38 +1000 (EST)
Date: Tue, 29 Aug 2006 17:52:16 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: Linux v2.6.18-rc5
Message-ID: <20060829155216.GA25861@aepfle.de>
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org>
	<20060829115537.GA24256@aepfle.de>
	<20060829130629.GW11309@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060829130629.GW11309@localdomain>
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 29, Nathan Lynch wrote:

> Hi Olaf-
> 
> Olaf Hering wrote:
> > On Sun, Aug 27, Linus Torvalds wrote:
> > 
> > > Pls test it out, and please remind all the appropriate people about any 
> > > regressions you find (including any found earlier if they haven't been 
> > > addressed yet).
> > 
> > > Nathan Lynch:
> > >       [POWERPC] Fix gettimeofday inaccuracies
> > 
> > Tested on B&W G3, iBook1 and a G4/466.
> > This patch causes deadlocks on ppc32, but not on ppc64. Have to verify
> > it on a vanilla kernel, but I'm sure there are no funky patches in
> > openSuSE.
> > 
> > https://bugzilla.novell.com/show_bug.cgi?id=202146
> 
> Sorry about that, does this (a partial revert of the change) fix it
> for you?

Yes, it works ok with this change.
