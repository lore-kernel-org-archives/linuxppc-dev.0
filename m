Date: Mon, 24 Jan 2000 10:52:59 -0800 (PST)
Message-Id: <200001241852.KAA04045@sade.ddi.com>
From: Jim Terman <terman@ddi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linuxppc-dev@lists.linuxppc.org
Subject: altivec instructions
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


We are trying to run a program that contains altivec instructions on a G4,
but the process keeps crashing (gdb will actually cause a kernal panic).
It looks like a bit in the MSR needs to be set.  What would be the best
way to modify the kernel to let this happen?

--
______________________________________________________________________________
Jim Terman       |   323 Vintage Park Dr.   |   Voice: (650) 356-5446
terman@ddi.com   |   Foster City, CA        |   Fax:   (650) 356-5490
Diab-SDS, Inc.   |   94404                  |   web site - http://www.ddi.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
