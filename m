Date: Sun, 18 Nov 2001 12:59:37 -0200 (BRST)
From: Cloves Ferreira Junior <cfj@gandalf.cefetgo.br>
To: linuxppc-dev@lists.linuxppc.org
Subject: gunzipping error
Message-ID: <Pine.LNX.4.10.10111181258180.9582-100000@gandalf.cefetgo.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I am trying to produce a bootable image to use with PPC 7025 F40 CHRP IBM
workstation. From kernel 2.4.10 until version 2.4.14 the boot can not
starts and the follow message appeared:

exit INIT-PROGRAM: ELF-LOADER
chrpboot starting: loaded at 0x00400000
gunzipping (0x00010000 <- 0x00416470:0x004e94bc)...DEFAULT CATCH!,
code=fff0020
 ok
0 >

Can anyone point to me what is happening and why can I correct this boot
process?
Thanks in advance,
  Cloves.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
