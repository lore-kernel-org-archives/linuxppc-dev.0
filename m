Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain;
  charset="us-ascii"
From: "S. Hebbar" <shebbar@india.tejasnetworks.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: denx 2.4.20 kernel memory leak
Date: Wed, 3 Mar 2004 14:44:15 +0530
MIME-Version: 1.0
Message-Id: <200403031444.15398.shebbar@india.tejasnetworks.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am noticing kernel memory leak when I am getting a file using ftp.
For each ftp get session, the skbuff_head_cache is increasing.

Original:
  skbuff_head_cache  17232  17232    160  718  718    1
After getting a 8 MB file.
  skbuff_head_cache  18094  18096    160  754  754    1

Finally, system runs out of memory and kernel start killing processes.

I don't think this is driver problem. I can "flud ping" (ping -f) for more
than 24 hours without loosing any memory. I am generating 4000 packets/second
to the target using "ping -f"

I am not sure if there is another application which causes memory leak.

I am using denx 2.4.20 kernel. My target processor is MPC8260.

Any help is much appreciated.

Regards,
Hebbar.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
