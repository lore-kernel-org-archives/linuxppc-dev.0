Message-ID: <20010507204100.56613.qmail@web9901.mail.yahoo.com>
Date: Mon, 7 May 2001 13:41:00 -0700 (PDT)
From: Freddy Lugo <wilflugo@yahoo.com>
Subject: Can not access memory after turning MMU on
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

After turning the MMU (turn_on_mmu) the next memory
access instruction (stwu) can not be translated, the
memory can not be accessed and the system halt.  I
check the list archives and there are references to
set the Debug Enable Register (DER) to an
"appropriate" value.  I am working with the MPC750 and
in the Users Manual I can't find any reference to such
register.  Also I checked my bdi2000 (in case it was a
register on the bdi) and I didn't found anything.

This register exists or has its counterpart on the
MPC750?  Besides the DER value, there are other
methods to work and find the problem?

Thanks,

Freddy Lugo

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
