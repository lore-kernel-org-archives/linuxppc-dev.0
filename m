Message-ID: <000301bef4f1$e70d3250$0601a8c0@honey.cs.tsinghua.edu.cn>
From: "Alan Wang" <wung_y@263.net>
To: "linuxppc mail list" <linuxppc-dev@lists.linuxppc.org>
Subject: memory protection without MMU
Date: Thu, 2 Sep 1999 10:54:34 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


in PPC401GF, there is only a real mode MMU. that means TLB, paging and addr
translation don't now exist at all. and so there is only one flat address
space. in this situation, is momery protection possible? if yes, how to
implement it?
thx

regards,
Wang


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
