To: <linuxppc-embedded@lists.linuxppc.org>
Subject: BAT mapping
From: "Linh Dang" <linhd@nortelnetworks.com>
Date: Tue, 29 Jun 2004 11:23:51 -0400
In-Reply-To: <1088518106.14216.1415.camel@hades.cambridge.redhat.com> (David
 Woodhouse's message of "Tue, 29 Jun 2004 10:08:27 -0400")
Message-ID: <wn5isdatmk8.fsf@linhd-2.ca.nortel.com>
References: <1088518106.14216.1415.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm porting Linux to our proprietary boards. it's 7447-based with
gt64260 bridge. We used vanilla 2.6.7 from kernel.org. It worked out
well (2 person/grunt/slave-dats to get it linux booted and with
nfs/telnet/gdb...) thank you very much for your work.

In the porting process, we change the bat mapping to used all the 8
DBAT registers. our new algorithm is quite generic and will work for
cpu without hi_bats as well. My question is why it was NOT done this
way but hard-coded to bat2 and bat3. Am I missing some subtle things?

Thanx

--
Linh Dang


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
