Date: Tue, 17 Sep 2002 11:32:50 -0700
From: Matt Porter <porter@cox.net>
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: kgdb with 2.4.20pre7 kernel on 405 target
Message-ID: <20020917113250.A21959@home.com>
References: <3D86F756.2040000@esd-electronics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D86F756.2040000@esd-electronics.com>; from matthias.fuchs@esd-electronics.com on Tue, Sep 17, 2002 at 11:35:18AM +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Sep 17, 2002 at 11:35:18AM +0200, Matthias Fuchs wrote:
> on the target. The kernel is exported from bitkeeper this morning.

<snip>

> What does this mean ? From now on I cannot interupt the target.
>
> Is this a problem with kgdb ?

In 2_4_devel, the 4xx debug infrastructure is in the middle of a
change which moves DBCR state from pt_regs to thread struct.
Without DBCR being context switched, anything using the 4xx
debug exception will be adversely affected.  This includes
kgdb and ptrace.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
