Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18591.30474.127939.243247@cargo.ozlabs.ibm.com>
Date: Mon, 11 Aug 2008 09:17:30 +1000
From: Paul Mackerras <paulus@samba.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: please pull cell merge branch
In-Reply-To: <200808091513.05251.arnd@arndb.de>
References: <1217620879.15667.145.camel@carll-linux-desktop>
	<200808081526.21405.arnd@arndb.de>
	<1218235184.6637.111.camel@carll-linux-desktop>
	<200808091513.05251.arnd@arndb.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	cel <cel@linux.vnet.ibm.com>, cbe-oss-dev@ozlabs.org,
	Carl Love <cel@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann writes:

> I've fixed one last bug in Carl's update for cell-oprofile (int flags
> instead of unsigned long flags) and made sure the comments fit the
> usual style. This fixes a long-standing bug that prevented us from
> using oprofile on SPUs in many real-world scenarios. Please
> pull from
> 
>  master.kernel.org:/pub/scm/linux/kernel/git/arnd/cell-2.6.git merge
> 
> so we can get it fixed in 2.6.27-rc3. Sorry for the size of the patch
> so late after the merge window, unfortunately it wasn't possible to
> fix the problem in a simpler way.
> 
> 	Arnd <><
> 
> ---
> 
>  arch/powerpc/oprofile/cell/pr_util.h       |   13 +
>  arch/powerpc/oprofile/cell/spu_profiler.c  |    4
>  arch/powerpc/oprofile/cell/spu_task_sync.c |  236 ++++++++++++++++++++++++---
>  drivers/oprofile/buffer_sync.c             |   24 ++
>  drivers/oprofile/cpu_buffer.c              |   15 +
>  drivers/oprofile/event_buffer.c            |    2
>  drivers/oprofile/event_buffer.h            |    7
>  include/linux/oprofile.h                   |   16 +
>  drivers/oprofile/cpu_buffer.c              |    4

Since you're touching generic oprofile code here, do you have an ack
from the oprofile maintainer?  Or is the oprofile maintainer listed in
MAINTAINERS (Robert Richter) no longer active or something?

Paul.
