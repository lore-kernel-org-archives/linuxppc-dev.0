Date: Wed, 2 Apr 2003 09:40:37 -0700
From: Matt Porter <porter@cox.net>
To: Jean-Denis Boyer <jdboyer@mediatrix.com>
Cc: Matt Porter <porter@cox.net>, kas turi <inox_kas@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Disabling data cache
Message-ID: <20030402094037.A31751@home.com>
References: <2702075D4DE2B043BF5EB82E9CFAD45B763543@mail1.mediatrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2702075D4DE2B043BF5EB82E9CFAD45B763543@mail1.mediatrix.com>; from jdboyer@mediatrix.com on Wed, Apr 02, 2003 at 09:28:21AM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Apr 02, 2003 at 09:28:21AM -0500, Jean-Denis Boyer wrote:
>
> There is a kernel configuration option for that: CONFIG_DCACHE_DISABLE.
> In the kernel configuration UI, look into the section 'MPC8260 CPM Options'.

There is no code backing that option in linuxppc_2_4_devel, it is useless.
Certainly one could take what one person did (in the old post I referenced)
and put it under a config option for debug purposes.  Yet another nice
project for somebody. :)

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
