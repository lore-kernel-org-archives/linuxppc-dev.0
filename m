From: "Brian Tucker" <briant@flyingpig.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: ASSERT_RTNL problems
Date: Wed, 19 Apr 2000 18:25:03 +0100
Message-ID: <002201bfaa24$32aee310$bc00a8c0@agamemnon>
MIME-Version: 1.0
Content-Type: text/plain;charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm trying to get Linux to run on the Sandpoint evaluation platform,
the kernel uncompresses, probes the PCI bus and finds and tests
the EEPro100 ethernet card that is installed in slot 3.

Whatever I do however I keep running into the following problem:

RTNL: assertion failed at devinet.c(784):inetdev_event
IP-Config: Unable to set interface netmask (-22).

I've tracked this down to the ASSERT_RTNL macro which is defined
in rtnetlink.h, but there my knowledge fails me regarding what is
happening with the various semaphores.

Any suggestions gratefully accepted,

thanks

Brian Tucker
Flying Pig Systems


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
