Date: Mon, 11 Feb 2002 16:36:05 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200202120036.g1C0a5215326@xdr.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux 2.4.17 bug, mmap of /dev/mem
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I found out more about the problem. If I mmap 2 regions that are distinct,
even though they map to the same physical address in non-cacheable memory,
if I only use one for reading and the other for writing, there is no
corruption of linux and the system works. The problem happens when I both
read and write to the same mmap'd area.

Easy enough workaround. Now maybe some kernel expert can figure it out???????

Later--
Dave

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
