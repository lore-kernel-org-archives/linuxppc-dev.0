Message-ID: <3AF638AC.659C8A1F@centurysys.co.jp>
Date: Mon, 07 May 2001 14:54:52 +0900
From: Tania Oka <tania@centurysys.co.jp>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: power saving
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I would like to reduce power consumption on a custom MPC855T board.  I
notice in arch/ppc/kernel/idle.c idled() that the power saving code
seems to be skipped for processors other than 603/750 types.  Can anyone
tell me why that is?  Is it not a good idea on the 855 for some reason?
Is there anyone who has tried this on the 855 (or 850 or 860)?  Any
comments on the general subject welcome.

Thanks


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
