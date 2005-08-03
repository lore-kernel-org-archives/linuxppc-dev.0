Return-Path: <jwboyer@jdub.homelinux.org>
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Eugene Surovegin <ebs@ebshome.net>
In-Reply-To: <20050802230537.GA9125@gate.ebshome.net>
References: <1123023575.2614.25.camel@cashmere.sps.mot.com>
	<20050802230537.GA9125@gate.ebshome.net>
Content-Type: text/plain
Date: Tue, 02 Aug 2005 21:38:15 -0500
Message-Id: <1123036695.4755.36.camel@yoda.jdub.homelinux.org>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: Beginning Merger Patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-08-02 at 16:05 -0700, Eugene Surovegin wrote:
> On Tue, Aug 02, 2005 at 05:59:35PM -0500, Jon Loeliger wrote:
> > Here is a patch to begin the process of merging
> > the PPC32 and PPC64 include directories into a
> > new common "powerpc" arch.
> > 
> > This patch introduces the include/asm-powerpc directory.
> > It then places into it, all of the files in asm-ppc and
> > asm-ppc64 that are essentially identical.  A stub is left
> > in asm-ppc and asm-ppc64 pointing to the unified files.
> > No real thought went into this set of files; these are
> > the dead-simple identical files for starters!
> 
> Hmm, I got an impression that we wouldn't touch ppc and ppc64 for 
> now and just _copy_ or create clean stuff into powerpc. I think this 
> will be much safer, at least at the beginning.

Safer, maybe.  But then you have triple maintenance, since all the files
in question were just duplicates.

Patches like this don't need to be applied right away.  They take time
and lots of vetting.  They can live as separate entities until they are
really ready to be committed.  That being said, I say go whole-hog and
do it as Jon has done.  Especially considering that he has a git tree
that can be worked from.

josh
