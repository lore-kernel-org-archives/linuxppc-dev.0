Date: Thu, 6 Sep 2001 10:10:14 -0700 (PDT)
From: James F Dougherty <jfd@GigabitNetworks.COM>
Message-Id: <200109061710.KAA13165@krakatoa.gigabitnetworks.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: SysVInit (RC Scripts) on HHL 2.0
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am using HHL 2.0 (2.4.2) on MPC8240 and I downloaded
the root filesystem RPM's from

ftp://ftp.mvista.com/pub/Journeyman/cd2/ppc_82xx/apps/*.rpm

and installed them on my root filesystem.

Question: How come none of the init scripts work?

I have to run:

devfsd /dev
mount -a

every time I boot. It spawns a getty, but none of the rc
files get called ...


Is there some bug in HHL 2.0 on ppc_82xx I don't know about?

			Thanks,
			-James


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
