Date: Thu, 3 Oct 2002 07:57:53 -0700
From: Matt Porter <porter@cox.net>
To: Paul Mackerras <paulus@samba.org>, Matt Porter <porter@cox.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Remove ocp-proc.c
Message-ID: <20021003075753.B4643@home.com>
References: <20021003062159.GA6160@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021003062159.GA6160@zax>; from david@gibson.dropbear.id.au on Thu, Oct 03, 2002 at 04:21:59PM +1000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Oct 03, 2002 at 04:21:59PM +1000, David Gibson wrote:
> This patch completely removes drivers/ocp/ocp-proc.c from 2.5, along
> with all references to it - it's been terminally broken for some time
> now.  Shall I commit this to linuxppc-2.5?

I think so.  In a previous thread you brought this up and I think
moving some of the provided infos into driverfs at a later point is
the goal, correct?  At any rate, it's the Right Thing To Do(tm).

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
