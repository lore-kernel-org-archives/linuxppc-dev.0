From: "ByungGiBaek" <weapon100@hanmail.net>
Reply-To: "ByungGiBaek" <weapon100@hanmail.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: [MPC860T] Bad pmd in pte_alloc: 000e01e5 ???
Date: Mon, 29 Jan 2001 00:04:05 KST
Message-Id: <20010129000405.HM.60000000001cYd1@www7.hanmail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  hi

  I am porting linux to our own MPC860T board.
  I think I successfully modified CONFIG_MBX lines to fit our board.
  And then downloaded 2.2.13 Montavista kernel and running...
  But our board gives me under messages and end.

  Could you give me any small clues ?
  Thank you.
  ByungGi Baek.

  ----------- messages ---------------------------------------
  ........
  loop: registered device at major 7
  NET4: Ethernet Bridge 008 for NET4.0
  eth0: CPM ENET Version 0.2, 22:a0:80:05:53:fe
  PPP: version 2.3.7 (demand dialling)
  TCP compression code copyright 1989 Regents of the University of California
  PPP line discipline registered.
  RAMDISK: Compressed image found at block 0
  VFS: Mounted root (ext2 filesystem).
  Freeing unused kernel memory: 28k int
  INIT: version 2.77 booti
  Bad pmd in pte_alloc: 000e01e5
  Segmentation fault
  INIT: PANIC: segmentation violation! sleeping for 30 seconds


==================================================
ByungGi Baek.
weapon100@hanmail.net


==================================================
우리 인터넷, Daum
평생 쓰는 무료 E-mail 주소 한메일넷
지구촌 한글 검색서비스 Daum FIREBALL
http://www.daum.net

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
