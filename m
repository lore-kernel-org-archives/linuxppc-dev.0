From: "Jacky Wang" <jacky@premierme.com.tw>
To: "Magnus Damm" <damm@opensource.se>
Cc: "Conn Clark" <clark@esteem.com>,
	"May Ling List" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Does anyone port m8xx_pcmcia driver to Linux Kernel successfully?
Date: Fri, 19 Apr 2002 10:39:57 +0800
Message-ID: <NFBBLKLHNAGPKBMPDMALMEJGKAAA.jacky@premierme.com.tw>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3CBE9546.9383BD0D@opensource.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Magnus,

Yes.
That's what I am using(pcmcia-cs 3.1.10 + gz00000.gz//is the patch file from webpage).

sorry for my mis-typing.

Jacky

-----Original Message-----
From: Magnus Damm [mailto:damm@opensource.se]
Sent: Thursday, April 18, 2002 5:44 PM
To: Jacky Wang
Cc: Conn Clark; May Ling List
Subject: Re: Does anyone port m8xx_pcmcia driver to Linux Kernel successfully?


Hi folks,

The patch file you are referring to, is that the same patch as I
released
in the mail below?

http://lists.linuxppc.org/linuxppc-embedded/200002/msg00093.html

If that is the case I think you should try pcmcia-cs-3.1.10 instead of
2.1.10.
Or was that a typo?

/ Magnus

Jacky Wang wrote:
>
> Conn,
>
> I found while use Linux 2.2.13 + pcmcia-cs 2.1.10 + patch file (w/o any modification), I couldn't re-compile pcmcia-cs successfully.
> They are what I work with:
> Debian OS w/ 2.2.18pre21 kernel
> powerpc-linux-gcc 2.95.2
> powerpc-linux-as 2.9.5
>
> Would you give me your advise? Or.. it's a problem about configurations of Makefile?
>
> Jacky
> -----Original Message-----
> From: Jacky Wang [mailto:jacky@premierme.com.tw]
> Sent: Thursday, April 18, 2002 9:31 AM
> To: Conn Clark
> Cc: May Ling List
> Subject: RE: Does anyone port m8xx_pcmcia driver to Linux Kernel successfully?
>
> Conn,
>
> while I enter the ftp site of MontaVista, I couldn't see anything on the site.
> If it is the patch file that Magnus loaded in the webpage?
>
> Jacky
>
> -----Original Message-----
> From: root@esteem.com [mailto:root@esteem.com]On Behalf Of Conn Clark
> Sent: Thursday, April 18, 2002 1:12 AM
> To: Jacky Wang
> Cc: May Ling List
> Subject: Re: Does anyone port m8xx_pcmcia driver to Linux Kernel successfully?
>
> Jacky Wang wrote:
> >
> > Conn,
> >
> > hmm......
> > sounds good.
> >
> > but, I am a newbie about programming with linux kernel and MPC850.
> > Could you tell me which kernel release and how to port it smoothly?
>
>         We are using kernel 2.2.13 and pcmcia card services 3.1.10 .
> Unfortunately our hardware is proprietary and doesn't have a full pcmcia
> interface. I had to comment out all the voltage detect and such. Other
> than that I just followed the instructions that came with the mpc8xx
> patch file. The patch used to be availible from montavista's ftp site
> but
> isn't any more.
>
> here is some help full notes.
>
> http://lists.linuxppc.org/linuxppc-embedded/200005/msg00227.html
>
> Conn
>
> --
>
> *****************************************************************
>   If you live at home long enough, your parents will move out.
> *****************************************************************
>
> Conn Clark
> Engineering Stooge                              clark@esteem.com
> Electronic Systems Technology Inc.              www.esteem.com
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
