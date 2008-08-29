Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 5D472DDEFF
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Aug 2008 07:45:32 +1000 (EST)
Message-ID: <48B86DF3.3090606@denx.de>
Date: Fri, 29 Aug 2008 23:45:23 +0200
From: Anatolij Gustschin <agust@denx.de>
MIME-Version: 1.0
To: SETTE AGOSTINO - technolabs <Agostino.Sette@technolabs.it>
Subject: Re: MPC8568MDS RAMDISK Problem
References: <F1F6EC0C8B75034F9E3A79FC85122E8E01000F98@aquib01a>
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8E01000F98@aquib01a>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

SETTE AGOSTINO - technolabs wrote:
> Hi all,
> 
> I am trying to port a RAMDISK Filesystem on the MPC8568MDS board but I
> have the following problem:

<snip>

> #
> # General setup
> #
> CONFIG_EXPERIMENTAL=y
> CONFIG_BROKEN_ON_SMP=y
> CONFIG_INIT_ENV_ARG_LIMIT=32
> CONFIG_LOCALVERSION=""
> CONFIG_LOCALVERSION_AUTO=y
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> CONFIG_SYSVIPC_SYSCTL=y
> # CONFIG_POSIX_MQUEUE is not set
> # CONFIG_BSD_PROCESS_ACCT is not set
> # CONFIG_TASKSTATS is not set
> # CONFIG_AUDIT is not set
> # CONFIG_IKCONFIG is not set
> CONFIG_LOG_BUF_SHIFT=14
> # CONFIG_CGROUPS is not set
> CONFIG_GROUP_SCHED=y
> # CONFIG_FAIR_GROUP_SCHED is not set
> # CONFIG_RT_GROUP_SCHED is not set
> CONFIG_USER_SCHED=y
> # CONFIG_CGROUP_SCHED is not set
> CONFIG_SYSFS_DEPRECATED=y
> CONFIG_SYSFS_DEPRECATED_V2=y
> # CONFIG_RELAY is not set
> # CONFIG_NAMESPACES is not set
> # CONFIG_BLK_DEV_INITRD is not set
------------------>^^^^^^^^^^^^^^^^^
Your kernel doesn't include RAM disk support.
Enable "Initial RAM filesystem and RAM disk" and
try again.

Best regards,
Anatolij
