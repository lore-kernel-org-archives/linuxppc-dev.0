Mime-Version: 1.0
Message-Id: <p06002003bbb501deaadc@[192.168.0.254]>
Date: Thu, 16 Oct 2003 22:33:38 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: setting altivec in .config?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've noticed in the last couple benh kernels that I cannot set
altivec to yes or no in the config using xconfig or menuconfig, and
that there is no mention of it in the .config file. Also when exiting
xconfig, an error is thrown trying to write CONFIG_ALTIVEC. It's all
consistent, but what's going on - should it be this way or am I
missing the obvious? I can compile, but when I'm building mol it
detects the kernel as noav, which feeds my suspicions.

I'm currently on 2.4.23-pre5-ben0, old world, with a G4/800 Sonnet
upgrade card.


Stefan Jeglinski


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
