To: linuxppc-dev@lists.linuxppc.org
Subject: Re: ati_drv.o & fonts in XFree86-4.1
From: Kohkichi Hosoda <khosoda@venus.dti.ne.jp>
In-Reply-To: <20010624015513C.kohkichi@venus.dti.ne.jp>
References: <20010624015513C.kohkichi@venus.dti.ne.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20010624161324J.kohkichi@venus.dti.ne.jp>
Date: Sun, 24 Jun 2001 16:13:24 +0900
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sorry for self-reply.

Application of XFree86-4.1-AJ-atim64.drv-v4.0.patch from
Fukui-san's src.rpm and recompilation of ati directory
almost solved the problem.  Actually, I exchanged original
drivers of xf4.1 for these new ati_drv.o and atimisc_drv.o.
I still have a little bit weird fonts on X, but it's OK and
much more readable.  In addition, x11perf --scroll500 showed
118.0/sec on 24 depth again.  Great!

Thank you for your kind advice, Oikawa-san.

Kohkichi Hosoda

E-mail address: khosoda@venus.dti.ne.jp

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
