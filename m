Date: Fri, 24 May 2002 17:10:14 -0700
From: Matt Porter <porter@cox.net>
To: Khai Trinh <kqtrinh@yahoo.com>
Cc: Matt Porter <porter@cox.net>, Dan Kegel <dkegel@ixiacom.com>,
	"'linuxppc-embedded@lists.linuxppc.org '" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: in_ntoa built error
Message-ID: <20020524171014.B21633@home.com>
References: <20020524164039.A21633@home.com> <20020524235414.36023.qmail@web11508.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020524235414.36023.qmail@web11508.mail.yahoo.com>; from kqtrinh@yahoo.com on Fri, May 24, 2002 at 04:54:14PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, May 24, 2002 at 04:54:14PM -0700, Khai Trinh wrote:
> But Matt, if I turn on CONFIG_BLK_DEV_INITRD or
> CONFIG_ROOT_NFS, the code will fail to build with
> built error in in_ntoa as I stated earlier. Dan
> suggested I replaced it with NIPQUAD. Did he mean
> in_ntoa or inet_ntoa?

This problem has been fixed for sometime in _devel, your code is
stale.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
