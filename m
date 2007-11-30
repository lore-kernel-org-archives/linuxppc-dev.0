Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 1976BDDE2D
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 02:24:17 +1100 (EST)
Date: Fri, 30 Nov 2007 09:27:42 -0600
From: Olof Johansson <olof@lixom.net>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/24] powerpc: 4xx PCI, PCI-X and PCI-Express support
	among others
Message-ID: <20071130152742.GB4196@lixom.net>
References: <1196403038.569525.367459803520.qpush@grosgo>
	<20071130141540.GA3117@lixom.net>
	<51DE5987-D0DD-4E62-A99A-3D23ECFA9908@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51DE5987-D0DD-4E62-A99A-3D23ECFA9908@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 30, 2007 at 09:12:34AM -0600, Kumar Gala wrote:
> 
> On Nov 30, 2007, at 8:15 AM, Olof Johansson wrote:
> 
> > On Fri, Nov 30, 2007 at 05:10:38PM +1100, Benjamin Herrenschmidt  
> > wrote:
> >
> >> There will be further cleanups and fixes before 2.6.25 opens
> >
> > May I suggest running them through checkpatch.pl? It finds stuff in  
> > over
> > half of the ones I tried it on :)
> 
> You know of anyone that's integrated checkpatch.pl w/a git commit or  
> git-add? (effective run checkpatch.pl on the index before you commit  
> it).

I normally do "quilt diff | checkpatch.pl -" when use quilt. You could
similarly do "git diff HEAD | checkpatch.pl -". You'd always get the
warning about missing signed-off-by though.


-Olof
