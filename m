Message-ID: <40C9D4C9.4030907@nortelnetworks.com>
Date: Fri, 11 Jun 2004 11:50:33 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
MIME-Version: 1.0
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Cc: rvinson@mvista.com, mgreer@mvista.com
Subject: trying to boot 2.6.6 on new version of Motorola mcpn765
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


We've got some mcpn765 cards that have different hardware and are not being
recognized by the current kernel code.

The differences are that the hawk chip is reporting revision 3, and the VIA
bridge is the VT82C686 [Apollo Super South] rather than the VT82C586/A/B
PCI-to-ISA [Apollo VP.

I'm not sure how different the 686 is from the 586--can I just go ahead and take
the same code path, or do I bypass it completely, or what?

Chris

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
