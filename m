Message-ID: <00b401c017a9$91f50640$bf0102c8@sc.mcel.mot.com>
From: "Rolf Liu" <rolfl@sc23.sc.mcel.mot.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: question about 'r2' !!!
Date: Wed, 6 Sep 2000 10:24:22 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi, all,
As everyone konws, Linux use register 'r2' as a reference of 'current',which
is realized by
GCC. Also, the exeception handling of Linux do some work about 'r2'.

I am currently engaged in compiling Linux-ppc source tree using a CC other
than GCC.
The CC can only produce the executable format of 'EABI', a convention made
by Motorola.
And 'EABI' use 'r2' as a base address register for reference of const data,
which can't
be changed. So I want to use a general global varialbe as 'current', leaving
'r2' to 'EABI'.

Anyone has some experence in such issue?
what consideration I must take?
I am pleased to get any comments from you .
Thanks a lot

Rolf


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
