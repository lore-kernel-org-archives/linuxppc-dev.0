From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15608.22230.504008.818858@argo.ozlabs.ibm.com>
Date: Sat, 1 Jun 2002 15:08:38 +1000 (EST)
To: linuxppc-embedded@lists.linuxppc.org
Subject: pt_regs.dbcr0/1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Is anyone prepared to speak up for the dbcr0 and dbcr1 fields that
someone added to struct pt_regs for 4xx in the 2_4_devel tree?

If not, they are going.  If so, we can discuss it.

Better still, does anyone have a clearly thought-out vision of how the
debug facilities on 4xx should be managed?

I would much prefer to see these fields put in the thread_struct
rather than pt_regs.  I am reluctant to change pt_regs without a good
reason since it is visible to userspace and is therefore part of the
kernel API.  If the intention is to make the debug facilities
available to userspace then the thread_struct is a good place to put
fields relating to the debug facilities.

Paul.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
