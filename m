From: "Jacky Wang" <jacky@premierme.com.tw>
To: "Conn Clark" <clark@esteem.com>
Cc: "May Ling List" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Does anyone port m8xx_pcmcia driver to Linux Kernel successfully?
Date: Thu, 18 Apr 2002 09:31:21 +0800
Message-ID: <NFBBLKLHNAGPKBMPDMALIEIJKAAA.jacky@premierme.com.tw>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3CBDACD9.A8F9DF27@esteem.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Conn,

while I enter the ftp site of MontaVista, I couldn't see anything on the site.
If it is the patch file that Magnus loaded in the webpage?

Jacky

-----Original Message-----
From: root@esteem.com [mailto:root@esteem.com]On Behalf Of Conn Clark
Sent: Thursday, April 18, 2002 1:12 AM
To: Jacky Wang
Cc: May Ling List
Subject: Re: Does anyone port m8xx_pcmcia driver to Linux Kernel successfully?


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
