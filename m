Message-ID: <3CBDACD9.A8F9DF27@esteem.com>
Date: Wed, 17 Apr 2002 10:11:53 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: Jacky Wang <jacky@premierme.com.tw>
Cc: May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Does anyone port m8xx_pcmcia driver to Linux Kernel successfully?
References: <NFBBLKLHNAGPKBMPDMALIEICKAAA.jacky@premierme.com.tw>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jacky Wang wrote:
>
> Conn,
>
> hmm......
> sounds good.
>
> but, I am a newbie about programming with linux kernel and MPC850.
> Could you tell me which kernel release and how to port it smoothly?

	We are using kernel 2.2.13 and pcmcia card services 3.1.10 .
Unfortunately our hardware is proprietary and doesn't have a full pcmcia
interface. I had to comment out all the voltage detect and such. Other
than that I just followed the instructions that came with the mpc8xx
patch file. The patch used to be availible from montavista's ftp site
but
isn't any more.

here is some help full notes.

http://lists.linuxppc.org/linuxppc-embedded/200005/msg00227.html



Conn


--

*****************************************************************
  If you live at home long enough, your parents will move out.
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
