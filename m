Date: Thu, 12 Apr 2001 15:58:13 -0600
From: Cort Dougan <cort@fsmlabs.com>
To: tom_gall@vnet.ibm.com
Cc: linuxppc-commit@fsmlabs.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: compiler or kernel source defines
Message-ID: <20010412155813.I4021@ftsoj.fsmlabs.com>
References: <3AD5F612.E3E282E8@vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3AD5F612.E3E282E8@vnet.ibm.com>; from tom_gall@vnet.ibm.com on Thu, Apr 12, 2001 at 06:38:10PM +0000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've been steering towards use of CONFIG_PPC which we set in the kernel
config.  I'd like to continue to use that for _all_ PPC's but we could have
CONFIG_PPC32 and CONFIG_PPC64 for each version.

If that'll work for you guys I can add those.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
