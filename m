Message-ID: <3CA3BF8C.BC3021BC@wvi.com>
Date: Thu, 28 Mar 2002 17:12:44 -0800
From: Jim Potter <jrp@wvi.com>
Reply-To: jrp@wvi.com
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: data access errors on 2.4.19-pre3
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm bringing up a recent 2_4_devel kernel (2.4.19-pre3, as I recall) on
our embedded board, and I'm seeing some trap 300's (data access
exception) in printk where it's parsing the string for emit_log_char.
Anyone else seeing this?  The target system is a 7450 on 64260,
ppcboot-1.1.5.

--
Sincerely,

Jim Potter
45th Parallel Processing

  Those that would give up a necessary freedom for
  temporary safety deserve neither freedom nor safety.
    -- Ben Franklin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
