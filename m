Date: Mon, 22 Mar 2004 11:02:14 +0100
Message-ID: <4057CCD40002AF4E@mssbzhh-int.msg.bluewin.ch>
In-Reply-To: <005a01c40fbf$27f738a0$ee00a8c0@CAT>
From: "Wolfgang Grandegger" <wolfgang.grandegger@bluewin.ch>
Subject: RE: [PATCH] fix compile of denx rtai ppc with gcc 3.3.2 
To: "Andrew Dennison" <andrew.dennison@motec.com.au>,
	linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>-- Original Message --
>From: "Andrew Dennison" <andrew.dennison@motec.com.au>
>To: <linuxppc-embedded@lists.linuxppc.org>
>Subject: [PATCH] fix compile of denx rtai ppc with gcc 3.3.2
>Date: Mon, 22 Mar 2004 14:38:35 +1100
>
>
>I had a few problems compiling Denx RTAI for ppc with gcc 3.3.2. Attached
>patches seem to fix this - at least the examples run on my MPC5200. Changes
>still compile ok on 2.95.4.
>
>For linuxppc_devel patched with
>patch-denx-linuxppc_2_4_devel-LABEL_2003_12_22_1500-ltt:
>
>Change formatting of __asm__ in ltt_clear_bit to be similar to ltt_set_bit
>to fix compile error.
>
>For rtai-24.1.12-denx.tar.bz2:
>
>Fix clobber list to fix compile error on gcc 3.3.2.

Thanks for the patches. I'm going to verify and commit them
into the RTAI 24.x and 3.x CVS repositories a.s.a.p.

This issue is off-topic on this list. Please send RTAI related
mails to rtai@rtai.org.

Wolfgang.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
