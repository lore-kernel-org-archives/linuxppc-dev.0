In-Reply-To: <4120DA20.2984.1BD2DC2@localhost>
References: <411B9AF9.12494.1DA4A94@localhost> <4120DA20.2984.1BD2DC2@localhost>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <B97F656A-EFB0-11D8-A698-003065F9B7DC@embeddededge.com>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: MPC82xx enet on SCC3
Date: Mon, 16 Aug 2004 14:18:51 -0400
To: "Oliver Fuchs" <olivers.lists@gmx.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Aug 16, 2004, at 10:00 AM, Oliver Fuchs wrote:


> Ok, it was a little bit more, but I have it.

Apologies, I had FCC on the brain.

> I have modified arch/ppc/config.in and arch/ppc/8260_io/enet.c so
> that it fits to SCC1-4 w/o further modifications there.

Has anyone ever taken the patch I posted for multiple SCC Enet
support and brought it up to date?  That would have solved this
problem as well.  I've given to several people, all promising to
update it and send it back (because they actually had hardware
to test it and I don't any longer).

> I would contribute this, if anyone wants to use it.

Just send it to me and I'll get it into some source base :-)

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
