Message-ID: <3994B357.E3FE9014@ncal.verio.com>
Date: Fri, 11 Aug 2000 19:15:51 -0700
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Darwin updates
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I tried syncing up my copy of the Darwin xnu project today.
The server was down for a while, but now that it is up there
are new updates. A real quick look shows Pismo sleep is enabled
in the core99 drivers (they still haven't sanitized out the
use of the word "Pismo"). I also noticed some updates to the
PMU ADB, network and USB drivers, and the HFS code.  There
is no sign of explict support for the cube or dual G4's in
the Core99 drivers (though the uniNorth network drivers
have had some gigabit code for a while).

Henry

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
