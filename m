From: jlhagen@collins.rockwell.com
Subject: prepboot, head.S questions.
To: linuxppc-dev@lists.linuxppc.org
Date: Wed, 6 Dec 2000 15:46:04 -0600
Message-ID: <OF2FC5D6C8.697FC432-ON862569AD.007549C4@collins.rockwell.com>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all,

does a FAQ exist for this list?? I have an obvious newbie question. Could
someone quickly explain the structure of arch/ppc, I'm really looking at
the different head.S files. It looks like the arch/ppc/kernel/head.S
contains low-level code for all architectures and the arch/ppc/[boot
coffboot etc..] are the different bootloaders. Is this correct??

Also from reading the list archives it sounded like the prepboot code from
Gabriel, or code based on his work,  was to eventually make it into the ppc
source tree. I believe this discussion was quite a while ago, 1999
sometime. Is this still the plan? Or maybe items from prepboot are being
merged into arch/ppc/boot ( If I understand the structure correctly )?
Some enlightenment would be greatly appreciated.

Thanks, John


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
