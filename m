Date: Fri, 12 Apr 2002 14:51:58 -0700
From: Jer_57 <jer_57@cox.net>
Reply-To: Jer_57 <jer_57@cox.net>
Message-ID: <184-1503797947.20020412145158@cox.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: dhcpd/bootp and 405 (walnut)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I know this has been discussed before, but I can't find a solution in
the archives.  We are trying to get some IBM405 (Walnut) boards to
boot with dhcpd but not succeeding.  We can boot them via bootp
though.  The version of dhcpd we have installed is:

[root@vail root]# rpm -qa |grep dhcp
dhcp-2.0pl5-8

from RedHat 7.2 install.

Does anyone know why this might not be working?  Is there something
we need to add to the dhcpd.conf file?  We have other boards booting
from dhcpd just fine (mbx860/821).

TIA
jer

--
Best regards,
 Jer_57                          mailto:jer_57@cox.net


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
