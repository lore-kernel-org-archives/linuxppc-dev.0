From: tom_gall@vnet.ibm.com
Message-ID: <3A2FC880.E2BADF64@vnet.ibm.com>
Date: Thu, 07 Dec 2000 17:27:28 +0000
Reply-To: tom_gall@vnet.ibm.com
MIME-Version: 1.0
To: berke@kis.uni-freiburg.de
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI questions
References: <3A2FC4BF.ABE6A0A8@kis.uni-freiburg.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thomas Berkefeld wrote:
>
> Will the future 2.4 kernel incorporate the PPC-PCI fixes or is it better
> to install one of the
> 2.4.0-pre's (which one?) plus the appropriate PCI-fix?

If you get the latest set of sources from fsmlabs then you will have the PPC-PCI
fixes... assuming you're taking about the new hose code etc.

> Is it possible to recompile Intel-based PCI-
> drivers and get them to work (apart from the reversed byte order)?

Yes... actually generally drivers just work assuming they were written
correctly. Byte order problems do happen tho.

Regards,

Tom

--
Tom Gall - PowerPC Linux Team    "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@rochcivictheatre.org
http://oss.software.ibm.com/developerworks/opensource/linux

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
