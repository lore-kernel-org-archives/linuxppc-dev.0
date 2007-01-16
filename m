Return-Path: <lethal@linux-sh.org>
Received: from smtp.ocgnet.org (smtp.ocgnet.org [64.20.243.3])
	by ozlabs.org (Postfix) with ESMTP id C9C99DDDEA
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 09:42:59 +1100 (EST)
Date: Wed, 17 Jan 2007 07:07:08 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 37/59] sysctl: C99 convert arch/sh64/kernel/traps.c and
	remove ABI breakage.
Message-ID: <20070116220708.GA10821@linux-sh.org>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
	<11689656622749-git-send-email-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11689656622749-git-send-email-ebiederm@xmission.com>
Cc: "<Andrew Morton" <akpm@osdl.org>, linux-mips@linux-mips.org,
	linux-parport@lists.infradead.org, heiko.carstens@de.ibm.com,
	ak@suse.de, linuxppc-dev@ozlabs.org, paulus@samba.org,
	aharkes@cs.cmu.edu, schwidefsky@de.ibm.com, tim@cyberelk.net,
	rtc-linux@googlegroups.com, linux-scsi@vger.kernel.org,
	kurt.hackel@oracle.com, coda@cs.cmu.edu, vojtech@suse.cz,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	James.Bottomley@SteelEye.com, clemens@ladisch.de,
	xfs@oss.sgi.com, xfs-masters@oss.sgi.com, andrea@suse.de,
	openipmi-developer@lists.sourceforge.net,
	linux-390@vm.marist.edu, codalist@TELEMANN.coda.cs.cmu.edu,
	a.zummo@towertech.it, tony.luck@intel.com,
	linux-ntfs-dev@lists.sourceforge.net, netdev@vger.kernel.org,
	aia21@cantab.net, linux-kernel@vger.kernel.org,
	ralf@linux-mips.org, containers@lists.osdl.org,
	linux390@de.ibm.com, philb@gnu.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 16, 2007 at 09:39:42AM -0700, Eric W. Biederman wrote:
> From: Eric W. Biederman <ebiederm@xmission.com> - unquoted
> 
> While doing the C99 conversion I notices that the top level sh64
> directory was using the binary number for CTL_KERN.  That is a
> no-no so I removed the support for the sysctl binary interface
> only leaving sysctl /proc support.
> 
> At least the sysctl tables were placed at the end of
> the list so user space did not see this mistake.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

Looks good, thanks Eric.

Acked-by: Paul Mundt <lethal@linux-sh.org>
