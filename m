Message-ID: <01C1DB26.5F692110.svacca@valcom.com>
From: Steven Vacca <svacca@valcom.com>
Reply-To: "svacca@valcom.com" <svacca@valcom.com>
To: "LinuxEmbeddedMailList (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: QMC SCC2 time slot data input to data buffer.
Date: Wed, 3 Apr 2002 15:43:58 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have an MPC860T setup, using QMC mode.

In my kernel driver, in the immap_t struct, I set the QMC Multi-channel
base ptr = the address of the Buffer Desc pool.  I also set the interrupt
queue ptr = the addr of the circular interrupt queue.

When a QMC channel is activated, for Rx, then TDM data should get
written to a buffer, thru the associated TDM time slot.

My question is,

is it OK to allocate the Rx Buff Descriptor Pool in the Kernel driver,
and then set the immap_t reg using that kernel space addr,
or do I need to do any kind of re-mapping in order
for the external CPM hardware section to access kernel space memory?

Once the data is written into the buffer, SCC2 should interrupt, for
data buff processing.

Thanks,

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
