From: linuxppc_em@sina.com
Message-ID: <00c301bf8fd9$48293ac0$1ac809c0@johnzhan>
Reply-To: <linuxppc_em@sina.com>
To: "zzh" <david-1z@263.net>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <38D88437.23494@mta2>
Subject: Re: About rs232 on motorola mpc8260 ads board
Date: Fri, 17 Mar 2000 14:23:15 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


----- Original Message -----
From: zzh <david-1z@263.net>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Wednesday, March 22, 2000 4:28 PM
Subject: About rs232 on motorola mpc8260 ads board


>
> Hello,everyone.
> I'm trying to make the SCC1 drived rs232 port of a motorola
> mpc8260 ads board work.The manual says it can direct connect
> to pc com port.But it seems the output from this board is not
> rs232 voltage.i.e -3 to -12 for logical one,3 to 12 for logical
> zero,nor is it TTL,it seems that it use 0 for logical 1,5.0v for
> logical 0,so it is rather annoying. I have to invert the output
> from 8260 ads,then use a TTL->232 converter to connect with PC,
> it works when i send char from 8260,but cannot work in the
> other direction.
> In addition,for a while,it output 232 signal,but i cannot
> reproduce it!!
> Does anyone has experience with this board?
> Thanks for your advice.
>                     davidzhang
>                     3/22/2000
>
> _____________________________________________
> 首都在线--中国人的网上家园 http://www.263.net
> @263.net中国最大的在线邮局 http://freemail.263.net
>


Pavel Roskin is right , that means to check RTS(from ads) or enable it manually.

b.r.
john zhan.
hacking time.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
