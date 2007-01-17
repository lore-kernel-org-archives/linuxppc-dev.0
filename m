Return-Path: <ak@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9BB83DDE41
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 15:27:20 +1100 (EST)
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 0/59] Cleanup sysctl
Date: Wed, 17 Jan 2007 15:21:43 +1100
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701171521.45323.ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	linux-parport@lists.infradead.org, heiko.carstens@de.ibm.com,
	linuxppc-dev@ozlabs.org, paulus@samba.org, aharkes@cs.cmu.edu,
	schwidefsky@de.ibm.com, tim@cyberelk.net,
	codalist@telemann.coda.cs.cmu.edu, rtc-linux@googlegroups.com,
	linux-scsi@vger.kernel.org, kurt.hackel@oracle.com,
	coda@cs.cmu.edu, vojtech@suse.cz,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	James.Bottomley@steeleye.com, clemens@ladisch.de,
	xfs@oss.sgi.com, xfs-masters@oss.sgi.com, andrea@suse.de,
	openipmi-developer@lists.sourceforge.net,
	linux-390@vm.marist.edu, a.zummo@towertech.it,
	tony.luck@intel.com, linux-ntfs-dev@lists.sourceforge.net,
	netdev@vger.kernel.org, aia21@cantab.net,
	linux-kernel@vger.kernel.org, ralf@linux-mips.org, lethal@linux-sh.org,
	Linux Containers <containers@lists.osdl.org>,
	linux390@de.ibm.com, philb@gnu.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 17 January 2007 03:33, Eric W. Biederman wrote:
> There has not been much maintenance on sysctl in years, and as a result is
> there is a lot to do to allow future interesting work to happen, and being
> ambitious I'm trying to do it all at once :)
>
> The patches in this series fall into several general categories.

[...]

The patches look good to me.

-Andi
