Message-ID: <3D99AEA7.1000005@ellemedia.com>
Date: Tue, 01 Oct 2002 17:18:15 +0300
From: Apostolos Meliones <meliones@ellemedia.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Segmentation fault and HiP3 vs HiP4 (8260 vs 8264)
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear colleagues,

At last, we solved the segmentation fault problem that we encountered
when trying to port kernel 2.4.7 on a HiP4 MPC8260 customized board
thanks to the kind assistance of a friend from the list!

We moved to a new kernel (we were using 2.4.7) to support the PVR of the
HiP4 versions of MPC826x, so we tested 2.4.12, 2.4.18 and 2.4.20. We did
our porting mostly on 2.4.20. We had almost everything there. However,
we encountered a serious error related to memory management regarding
one of our drivers that was based on a port from MPC860 coded for kernel
2.4.4. Alternatively, we kept on working in parallel on 2.4.7 to find
out and cancel the PVR checks that were instructing the kernel to use an
incorrect cpu among the several available processor versions. This was
responsible for the segmentation fault. We deceived the kernel to take
8264 for 8260 and this way the problem was solved !!

Best regards

Apostol


----------------------------------------
Dr. Apostol Meliones
Ellemedia Technologies
223 Syngrou Ave., 17121, Athens, Greece
Tel: +30-10-9373095, Fax: +30-10-9370386


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
