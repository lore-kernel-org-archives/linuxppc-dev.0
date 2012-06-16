Return-Path: <wfg@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by ozlabs.org (Postfix) with ESMTP id 5B32BB7041
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jun 2012 11:53:08 +1000 (EST)
Date: Sat, 16 Jun 2012 09:53:01 +0800
From: Fengguang Wu <wfg@linux.intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [driver-core:driver-core-linus 6/6]
 drivers/firmware/iscsi_ibft_find.o: In function `kmsg_dump_rewind':
 (.text+0x18): multiple definition of `kmsg_dump_rewind'
Message-ID: <20120616015301.GB7847@localhost>
References: <4fdbcd2f.Ta8kRp58FRzqrqaL%wfg@linux.intel.com>
 <20120616111550.597c8f605fa64fb9789fa506@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120616111550.597c8f605fa64fb9789fa506@canb.auug.org.au>
Cc: devel@driverdev.osuosl.org, linuxppc-dev@lists.ozlabs.org,
 Kay Sievers <kay@vrfy.org>, linux-mtd@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Stephen,

On Sat, Jun 16, 2012 at 11:15:50AM +1000, Stephen Rothwell wrote:
> Hi,
> 
> On Sat, 16 Jun 2012 08:02:55 +0800 wfg@linux.intel.com wrote:
> >
> > Kernel build failed on
> > 
> > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git driver-core-linus
> > head:   e2ae715d66bf4becfb85eb84b7150e23cf27df30
> > commit: e2ae715d66bf4becfb85eb84b7150e23cf27df30 [6/6] kmsg - kmsg_dump() use iterator to receive log buffer content
> > config: i386-randconfig-usb1 (attached as .config)
> 
> Please have a good look at what you are sending out.  I don't understand
> why this report has come to linuxppc-dev (the patch touches an
> arch/powerpc file, but none of the problems reported are in that file).

Because I blindly used the lists reported by scripts/get_maintainer.pl ...

I'll build a "mailing list <=> git tree" mapping based on MAINTAINERS
and use that to build CC list, rather than depending on the source files
that the patch randomly touch.

> You should put the .config on a web site somewhere and include the URL and
> you should not include the whole patch (these were all quite large) -
> people can find them given a tree and commit (like above).

That's a valid option. Unfortunately I don't have a website to run
this for now. Anyway, I'm still on the way improving the kernel
testing backend based on your and others' feedback :)

> And you sent out 7 reports for the same patch!

That's where a website could help. Different kconfigs may trigger
different errors for the same commit. So it's a hard decision whether
to send emails for all broken kconfigs and risk being a noise, or to
limit it to the first broken kconfig and risk lose of information.

For now, I can send the patch author all the emails, but CC others
only on the first one (with an statement that there are actually more
errors in other kconfigs). So that the author that is responsive for
fixing the bug get the full information, while the others still can
keep track of the error situation.

> I approved this bunch, but will not (unless pressured) approve any more.
> This scatter gun automated approach is like the boy crying wolf.
> I appreciate the effort, but please tone down the reports considerably.

Heh, thanks! We should be able to reach a polished automated system
that's fast and accurate in the end :-)

Thanks,
Fengguang
