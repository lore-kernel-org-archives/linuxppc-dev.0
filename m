Date: Thu, 7 Nov 2002 12:14:35 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Anders Blomdell <anders.blomdell@control.lth.se>,
	linuxppc-dev@lists.linuxppc.org,
	Hollis Blanchard <hollis@austin.ibm.com>
Subject: [CFT] CONFIG_ALL_PPC and post-PReP (MVME2600, etc) systems
Message-ID: <20021107191435.GD6164@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hey all.  I've just commited code to the linuxppc-2.5, linuxppc_2_4 and
linuxppc_2_4_devel trees which should fix the problem seen when a
CONFIG_ALL_PPC kernel is booted on a machine which is identified as
'prep' but lacks an MPC10x.  I've tested my PowerStack, and it still
works, but I'm unsure as to:
a) Does this fix the problem seen on MVME2600?  I would assume so.
b) The broken HW which caused us to go from polling to int-ack, what
host bridge was this exactly?  We currently use the MPC10x-specific
address on MPC105/MPC106/MPC107 (completeness), and based on the
original comment I assume that it was MPC10x HW.  Can someone confirm?
Thanks.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
