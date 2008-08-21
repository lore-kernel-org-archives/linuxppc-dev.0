Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18604.60738.523963.886786@drongo.ozlabs.ibm.com>
Date: Thu, 21 Aug 2008 14:21:22 +1000
From: Paul Mackerras <paulus@samba.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: powerpc/cell/oprofile: fix mutex locking for spu-oprofile
In-Reply-To: <200808201519.19453.arnd@arndb.de>
References: <1217620879.15667.145.camel@carll-linux-desktop>
	<200808110925.08485.arnd@arndb.de>
	<20080820123944.GQ13011@erda.amd.com>
	<200808201519.19453.arnd@arndb.de>
Cc: Robert Richter <robert.richter@amd.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, oprofile-list@lists.sourceforge.net,
	cel <cel@linux.vnet.ibm.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann writes:

> Paul, any chance we can still get this into 2.6.27?

Possibly.  We'll need a really good explanation for Linus as to why
this is needed (what regression or serious bug this fixes) and why it
is late.  Can you send me something explaining that?

> I've added the Ack and uploaded it again for you to
> pull from
> 
>  master.kernel.org:/pub/scm/linux/kernel/git/arnd/cell-2.6.git merge

Are you sure you actually managed to update that?

$ git ls-remote master.kernel.org:/pub/scm/linux/kernel/git/arnd/cell-2.6.git merge
f90a87b5f5fa46dc6c556e9267a6f25a95fbef14        refs/heads/merge

and f90a87b5f5fa46dc6c556e9267a6f25a95fbef14 is the same commit from
2008-08-09 that you asked me to pull previously.

Paul.
