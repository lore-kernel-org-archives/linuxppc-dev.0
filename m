Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15316.1504.603255.831736@cargo.ozlabs.ibm.com>
Date: Mon, 22 Oct 2001 21:41:20 +1000 (EST)
To: "Kalyan" <kalyand@cruise-controls.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Wild Pointer!!!! ( some more info )
In-Reply-To: <03c101c15a76$7d067320$aac8a8c0@cruise>
References: <03c101c15a76$7d067320$aac8a8c0@cruise>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kalyan writes:

>           I recently ported the linux kernel v 2.4.11-pre5  to MDPPro (
>   MPC860T processor ) board..the kernel dies with an Oops and everytime at a
>   different place.... i have taken the code from bitkeeper

The linuxppc_2_4 tree or the linuxppc_2_4_devel tree?  Have you made
local changes?  If so what are they?

>   Call backtrace:
>   C0014538 C0012314 C00121D4 C0011E14 C0003FAC C00026E0 C0003CF0
>   C0003D04 C0002270 C00FC744 C0002138

Have you looked up these addresses in System.map?  That could be
enlightening.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
