Date: Tue, 8 Oct 2002 14:02:50 -0700
From: Andrew May <acmay@acmay.homeip.net>
To: Paul Mackerras <paulus@samba.org>
Cc: Matt Porter <porter@cox.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: 4xx re-org request
Message-ID: <20021008210250.GA27943@acmay.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


There are some things that I would like to see come out of the 4xx
code reorginization. One is the PCI mapping that was already discussed
with Matt, but another would be the ablity to build one kernel for
more than one board type.

I posted this patch back in April that started to do this but there
was no intrest in it then. I beileive Armin said that it was not
one of the design goals of 4xx structure.

http://lists.linuxppc.org/linuxppc-embedded/200204/msg00408.html

The patch does show that it shouldn't be too hard to remove the
common patch in ppc4xx_setup and move it into board specific files
by changing how the ppc_md stucture is setup.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
