Date: Wed, 7 Apr 2004 10:46:25 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: linux-2.5-ocp, 2.6, 4xx, and others
Message-ID: <20040407104625.A14212@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

The linux-2.5-ocp tree (bk://source.mvista.com/linux-2.5-ocp) has
been updated to 2.6.5 and has a number of enhancements/fixes:

* New OCP infrastructure from 2.4
* A number of ibm_ocp (4xx) updates (some helpers)
* 4xx IIC and EMAC drivers no longer using bd_t to pass info
* All 4xx ports (that were in linux-2.5) build.
* ash, ebony, evb405ep, ocotea, redwood6, walnut tested.

Anybody doing 2.6 4xx work (new ports, forward ports) should be
using this tree and looking at the working examples. Same thing
for any other subarches that are starting to use OCP.

BenH is working on the PM support in OCP and at some time in the
future this should all be going into Linus' tree.

Any questions/suggestions/patches/flames to me.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
