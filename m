Message-ID: <20011025073649.16418.qmail@web15005.mail.bjs.yahoo.com>
Date: Thu, 25 Oct 2001 15:36:49 +0800 (CST)
From: =?gb2312?q?Dross=20Zhou?= <zjuzhou@yahoo.com.cn>
Subject: Re: About ppp and pppoe in linux 2.4.2
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3BD79D78.891C22F4@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Oh,i add these config option ,then they works well
now.
It can connect server by adsl-start scripts.
Thanks.




 --- Mark Hatle <fray@mvista.com>
> Dross Zhou wrote:
> >
> > Now I have make a little progrss.
> > In Hard Hat 1.2(linuxppc2.2.14),I used pppd and
> pppoe
> > ,they works well.
> > But our system works in HHL2.0,I want to know what
> > config option  must be selected in hhl2.0.
> > Here is my choose:
> >
> > CONFIG_PPP=y
> > # CONFIG_PPP_MULTILINK is not set
> > # CONFIG_PPP_ASYNC is not set
> > # CONFIG_PPP_SYNC_TTY is not set
> > # CONFIG_PPP_DEFLATE is not set
> > # CONFIG_PPP_BSDCOMP is not set
> > CONFIG_PPPOE=y
> > # CONFIG_SLIP is not set
> >
> > Is here wrong?
>
> I don't see anything immediately wrong, but I would
> suggest you turn on
> DEFLATE and BSDCOMP.
>
> --Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
