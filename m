Return-Path: <James.Bottomley@SteelEye.com>
Received: from hancock.sc.steeleye.com (hancock.steeleye.com [71.30.118.248])
	by ozlabs.org (Postfix) with ESMTP id D8557DE263
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 05:26:21 +1100 (EST)
Subject: Re: [PATCH 20/59] sysctl: cdrom Don't set de->owner
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <11689656373737-git-send-email-ebiederm@xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
	<11689656373737-git-send-email-ebiederm@xmission.com>
Content-Type: text/plain
Date: Tue, 16 Jan 2007 12:19:34 -0600
Message-Id: <1168971574.2789.14.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Cc: "<Andrew Morton" <akpm@osdl.org>, linux-mips@linux-mips.org,
	linux-parport@lists.infradead.org, heiko.carstens@de.ibm.com,
	ak@suse.de, linuxppc-dev@ozlabs.org, paulus@samba.org,
	aharkes@cs.cmu.edu, schwidefsky@de.ibm.com, tim@cyberelk.net,
	rtc-linux@googlegroups.com, linux-scsi@vger.kernel.org,
	kurt.hackel@oracle.com, coda@cs.cmu.edu, vojtech@suse.cz,
	linuxsh-shmedia-dev@lists.sourceforge.net, clemens@ladisch.de,
	xfs@oss.sgi.com, xfs-masters@oss.sgi.com, andrea@suse.de,
	openipmi-developer@lists.sourceforge.net,
	linux-390@vm.marist.edu, codalist@TELEMANN.coda.cs.cmu.edu,
	a.zummo@towertech.it, tony.luck@intel.com,
	linux-ntfs-dev@lists.sourceforge.net, netdev@vger.kernel.org,
	aia21@cantab.net, linux-kernel@vger.kernel.org,
	ralf@linux-mips.org, lethal@linux-sh.org,
	containers@lists.osdl.org, linux390@de.ibm.com, philb@gnu.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-01-16 at 09:39 -0700, Eric W. Biederman wrote:
> From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

These three look OK:

[PATCH 15/59] sysctl: scsi remove unnecessary insert_at_head flag
[PATCH 19/59] sysctl: cdrom remove unnecessary insert_at_head flag
[PATCH 20/59] sysctl: cdrom Don't set de->owner

So you can add an ACK from me.

It would have been nice not to have 56 other irrelevant patches sprayed
over the list and into my inbox, though ...

James
