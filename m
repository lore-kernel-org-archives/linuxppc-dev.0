Message-ID: <000301bef938$78001a30$02456fa6@honey.cs.tsinghua.edu.cn>
From: "Alan Wang" <wung_y@263.net>
To: "linuxppc mail list" <linuxppc-dev@lists.linuxppc.org>
Subject: about SAC register of PPC401GF
Date: Tue, 7 Sep 1999 14:40:10 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi,
    in PPC401GF, there is 4G addressing space. so in SAC register, each bit
control a block of 128M. But in pratice, embedded system do not have so many
memory. Even one bit of SAC register(128M) seems too big. does anyone know
why IBM design it like this? under the condition of no address translation
available, if 32-bit address pratical?

regards,
Wang


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
