Return-Path: <schwidefsky@de.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [195.212.29.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D5E92DDDF9
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 23:10:19 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate2.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l0HCADsY150662
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 12:10:13 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l0HCADAn839816
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 12:10:13 GMT
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l0HCAAxE027104
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 12:10:13 GMT
Subject: Re: [PATCH 0/59] Cleanup sysctl
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Wed, 17 Jan 2007 13:10:13 +0100
Message-Id: <1169035813.7711.7.camel@localhost>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	linux-parport@lists.infradead.org, heiko.carstens@de.ibm.com,
	ak@suse.de, linuxppc-dev@ozlabs.org, paulus@samba.org,
	aharkes@cs.cmu.edu, tim@cyberelk.net, rtc-linux@googlegroups.com,
	linux-scsi@vger.kernel.org, kurt.hackel@oracle.com,
	coda@cs.cmu.edu, vojtech@suse.cz,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	James.Bottomley@SteelEye.com, clemens@ladisch.de,
	xfs@oss.sgi.com, xfs-masters@oss.sgi.com, andrea@suse.de,
	openipmi-developer@lists.sourceforge.net,
	linux-390@vm.marist.edu, codalist@TELEMANN.coda.cs.cmu.edu,
	a.zummo@towertech.it, tony.luck@intel.com,
	linux-ntfs-dev@lists.sourceforge.net, netdev@vger.kernel.org,
	aia21@cantab.net, linux-kernel@vger.kernel.org,
	ralf@linux-mips.org, lethal@linux-sh.org,
	Linux Containers <containers@lists.osdl.org>,
	linux390@de.ibm.com, philb@gnu.org
Reply-To: schwidefsky@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-01-16 at 09:33 -0700, Eric W. Biederman wrote:
> There has not been much maintenance on sysctl in years, and as a result is
> there is a lot to do to allow future interesting work to happen, and being
> ambitious I'm trying to do it all at once :)

s390 parts look good. Kernels boots and the system controls are still
working. I had to add an #include <linux/uaccess.h> to ipc/ipc_sysctl.c
to get the kernel compiled. That include should be added to patch #51.

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com> for:
[PATCH 33/59] sysctl: s390 move sysctl definitions to sysctl.h
[PATCH 34/59] sysctl: s390 Remove unnecessary use of insert_at_head

and the s390 parts of 
[PATCH 55/59] sysctl: Remove insert_at_head from register_sysctl

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.
