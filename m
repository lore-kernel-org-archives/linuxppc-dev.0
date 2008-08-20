Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Robert Richter <robert.richter@amd.com>
Subject: Re: powerpc/cell/oprofile: fix mutex locking for spu-oprofile
Date: Wed, 20 Aug 2008 15:19:18 +0200
References: <1217620879.15667.145.camel@carll-linux-desktop>
	<200808110925.08485.arnd@arndb.de>
	<20080820123944.GQ13011@erda.amd.com>
In-Reply-To: <20080820123944.GQ13011@erda.amd.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808201519.19453.arnd@arndb.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, oprofile-list@lists.sourceforge.net,
	cel <cel@linux.vnet.ibm.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 20 August 2008, Robert Richter wrote:

> > Signed-off-by: Carl Love <carll@us.ibm.com>
> > Signed-off-by: Maynard Johnson <maynardj@us.ibm.com>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Robert Richter <robert.richter@amd.com>
> 

Thanks Robert.

Paul, any chance we can still get this into 2.6.27?

I've added the Ack and uploaded it again for you to
pull from

 master.kernel.org:/pub/scm/linux/kernel/git/arnd/cell-2.6.git merge

	Arnd <><
