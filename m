Message-ID: <3AE47F92.722FB4E9@matrox.com>
Date: Mon, 23 Apr 2001 15:16:34 -0400
From: Alexandre Nikolaev <anikolae@matrox.com>
Reply-To: Alexandre.Nikolaev@matrox.com
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: ppc little-endian port amendment
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sorry gentlemen, we forgot to mention that before launching the kernel
you have to switch the
processor to Little endian mode (kernel loader for instance can do it):

lis r4, 1
addi r4,r4,1
sync
isync
mtmsr r4
isync
sync

regards

Sebastien Cote
Alexandre Nikolaev

--
*****************************************
| Alexandre Nikolaev
| Software Designer
| Matrox Electronic Systems Ltd
| Imaging Department
| Tel. (514) 8226000 ext. 2323
| E-mail: Alexandre_Nikolaev@matrox.com
*****************************************:)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
