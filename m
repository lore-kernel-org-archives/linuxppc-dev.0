Message-ID: <39C8AE7A.88A53FBA@sxb.bsf.alcatel.fr>
Date: Wed, 20 Sep 2000 14:32:58 +0200
From: Christian Batt <Christian.Batt@sxb.bsf.alcatel.fr>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC8xx DPRAM : m8xx_cpm_hostalloc
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello

I am currently working with a MPC860 (Linux kernel 2.2.13)
and I need more DPRAM space for my BD/buffers, than the
space between IMMR+0x2800 - IMMR+0x2F00 (1792 bytes).

I know the 860 has 5K of DPRAM : 4K + 1K of parameter RAM.

So, I have tried to modify the value of
    CPM_DATAONLY_BASE   from 0x0800 to 0x0000
    CPM_DATAONLY_SIZE     from 0x0700 to 0x1000
but my kernel (compiled with those values) stucks early at boot time :

...
Uncompressing Linux... done.
Now booting the kernel
    -(and no more)-

Does anybody have an idea why it seems I cannot use the space
between IMMR+0x2000-IMMR+0x2800 for my module ?

Thanks for any help

Regards

Christian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
