Date: Fri, 24 Mar 2000 20:51:41 +0200 (EET)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Gabriel Paubert <paubert@iram.es>
cc: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        Ani Joshi <ajoshi@shell.unixbox.com>, linuxppc-dev@lists.linuxppc.org,
        bh40@calva.net
Subject: Re: proper regw and regrw16?
In-Reply-To: <Pine.HPX.4.10.10003241852180.14656-100000@gra-ux1.iram.es>
Message-ID: <Pine.LNX.4.21.0003242048190.2433-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 24 Mar 2000, Gabriel Paubert wrote:

> >      3e8:       7c 0b 4f 2c     sthbrx  r0,r11,r9
> 				  ^^^^^^
> If it's stHbrx and not stWbrx then you'll probably be in trouble later.
> and it looks it is sthbrx from the HEX value, otherwise it would be
> 7c0b4d2c.
>

 OUCH, bad typo in my defines (how the driver managed to run with this
for almost a week is something that i can't imagine)

>
> 	Gabriel.

  Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
