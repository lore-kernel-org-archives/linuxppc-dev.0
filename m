Message-ID: <000201bef600$257e7530$02456fa6@honey.cs.tsinghua.edu.cn>
From: "Alan Wang" <wung_y@263.net>
To: "linuxppc mail list" <linuxppc-dev@lists.linuxppc.org>
Subject: something about storage attribute control(SAC) register
Date: Fri, 3 Sep 1999 15:44:06 +0800
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


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
