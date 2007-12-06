Return-Path: <niklaus.giger@member.fsf.org>
Received: from viefep23-int.chello.at (viefep18-int.chello.at [213.46.255.22])
	by ozlabs.org (Postfix) with ESMTP id 9A509DE56B
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Dec 2007 07:04:22 +1100 (EST)
From: Niklaus Giger <niklaus.giger@member.fsf.org>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: Problem compiling sequoia using DENX kernel. Xenomai-patch
	required?
Date: Thu, 6 Dec 2007 21:04:29 +0100
References: <20071206145506.4C81A2430C@gemini.denx.de>
In-Reply-To: <20071206145506.4C81A2430C@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712062104.30555.niklaus.giger@member.fsf.org>
Cc: linuxppc-embedded@ozlabs.org
Reply-To: niklaus.giger@member.fsf.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Am Donnerstag, 6. Dezember 2007 schrieb Wolfgang Denk:
> In message <200712042314.38498.niklaus.giger@member.fsf.org> you wrote:
> > Am Dienstag, 4. Dezember 2007 schrieb Wolfgang Denk:
> > <...>
> > > I'm afraid "normal" here still means arch/ppc  -  hopefully  for  not
> > > long any more. Note: a matching Xenomai patch for arch/ppc will be in
> > > Xenomai 2.4 when it comes out in a few days.
> > Thanks a lot for your explanation. I took 
> > ksrc/arch/powerpc/patches/adeos-ipipe-2.6.23-ppc-1.6-00.patch 
> > from the xenomai trunk and was able to compile and boot successfully
> > the yosemite board (using ARCH=ppc). Will try the sequoaia board tomorrow.
> > 
> > I hope that this is a good starting point to get my custom PPC440EPx board 
> > into shape. I think once the arch/powerpc will work for PPC440 it should not 
> > be a lot of work to port it from ppc -> powerpc.
> 
> Actually the arch/powerpc tree is working fine here, too.
> 
> You might have been unlucky and cloning / pulling  our  tree  at  the
> wrong time; we had a stale DENX-v2.6.23.9 tag in there for some time;
> unfortunately  the  fix  doesn't  propagate  as  your  side thinks it
> already has a valid tag.
> 
> Please either "rm .git/refs/tags/DENX-v2.6.23.9" and pull  again,  or
> throw  away  the  whole  tree  and  clone again. Sorry for the incon-
> venience. And please let me know if this helps (it should).
After following your receipt I recompiled and booted the sequoia board.
Everything seems to work.

Thank you again for your tip. You are always very helpful.
Best regards,

Niklaus Giger
