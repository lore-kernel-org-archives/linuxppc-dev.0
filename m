Subject: Kernel profiling for PPC architecture?
To: linuxppc-dev@lists.linuxppc.org
Date: Tue, 15 Aug 2000 16:06:04 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000815060604.7D68850510@brixi.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


A little bit of investigating as to why 'readprofile' output always gave
zeros led me to find that kernel profiling doesn't appear to be implemented
for the ppc architecture in the standard 2.2 or 2.4 kernels.

Has anyone done any work on this, or is anyone aware of any patches to add
this functionality to the ppc subtree?

Thanks,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
