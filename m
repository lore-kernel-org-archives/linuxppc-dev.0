Message-ID: <000601c21be1$7b4cfdb0$3cabfe81@bgjung13>
Reply-To: "Boo Geum Jung" <bgjung@etri.re.kr>
From: "Boo Geum Jung" <bgjung@etri.re.kr>
To: "Wolfgang Denk" <wd@denx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <20020625001927.21B6C10340@denx.denx.de>
Subject: Re: PPCboot+MPC7410+Sandpoint 
Date: Tue, 25 Jun 2002 09:44:36 +0900
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Of course, I can.
But right now, it's not clear, it conatins some trial codes.
I'll make it clear under ppcboot-1.1.6.
I'll send you then.
In briefly speaking,
I added a line "#define CONFIG_MPC7410          1" in
config_Sandpoint8245.h.
And use files in cpu/74xx_7xx/ direcoty instaed of mpc824x/
I didn't know well how to make new config file(config_Sandpoint7410.h).
So I modified the original files.
I'll find out the way and I'll modify in smart way.

----- Original Message -----
From: "Wolfgang Denk" <wd@denx.de>
To: "Boo Geum Jung" <bgjung@etri.re.kr>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sent: Tuesday, June 25, 2002 9:19 AM
Subject: Re: PPCboot+MPC7410+Sandpoint


> In message <00cd01c21bdd$7160d910$3cabfe81@bgjung13> you wrote:
> >
> > Yes, it works.
> > I worked with include/config_Sandpoint8245.h and cpu/74xx_7xx.
>
> Can you please send me your (modified) config file as patch?
>
> Thanks in advance,
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> Q: What do you get when you cross an ethernet with an income statement?
> A: A local area networth.
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
