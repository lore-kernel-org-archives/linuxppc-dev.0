Message-ID: <3CCE4ACE.8080204@thales-bm.com>
Date: Tue, 30 Apr 2002 09:42:06 +0200
From: Julien Eyries <julien.eyries@thales-bm.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Linux think my 8260 @200Mhz  is doing 13 Mips ???!!?
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello,

  i have a strange question : our 8260 is clocked externally with 66Mhz
clock and is configured to have its core frequency at 200Mz.
But Linux is giving me this message when booting :

*****
Warning: real time clock seems stuck!
Calibrating delay loop... 13.15 BogoMIPS
******

        is that really 13 MIPS ?
        i hope the computation is wrong !!
        any idea ?


thanks,
Julien.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
