Message-ID: <BAF533FC7E646143A766A99F5A1E5F38229574@esvee0bcnmsx02>
From: "Romero, Miguel Angel" <MiguelAngel.Romero@eu.sony.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Kernel Threads
Date: Fri, 25 Apr 2003 08:53:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


When writting device drivers as modules, I create threads on the kernel
using "kernel_thread". Threads are working when installing "insmod".

Problem is when removing the module "rmmod", I haven't found any function to
remove the created thread at init stage, and the kernel gets corrupted ( I
cannot install again the module I have removed )

How do I remove the kernel threads at clean up process ?

Thanks.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
