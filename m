From: "Jacky Wang" <jacky@premierme.com.tw>
To: "Conn Clark" <clark@esteem.com>
Cc: "May Ling List" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Does anyone port m8xx_pcmcia driver to Linux Kernel successfully?
Date: Wed, 17 Apr 2002 09:23:19 +0800
Message-ID: <NFBBLKLHNAGPKBMPDMALIEICKAAA.jacky@premierme.com.tw>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3CBC55BF.C3E5870F@esteem.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Conn,

hmm......
sounds good.

but, I am a newbie about programming with linux kernel and MPC850.
Could you tell me which kernel release and how to port it smoothly?

Jacky
-----Original Message-----
From: root@esteem.com [mailto:root@esteem.com]On Behalf Of Conn Clark
Sent: Wednesday, April 17, 2002 12:48 AM
To: Jacky Wang
Cc: May Ling List
Subject: Re: Does anyone port m8xx_pcmcia driver to Linux Kernel successfully?


Jacky Wang wrote:
>
> Hi everyone,
>
> I am interesting about how to port m8xx_pcmcia driver to linux kernel w/ MPC850.
>
> Would you mind to share your successful experience with me?
>
> Best Regards
> Jacky Wang
>

We have done it. There shouldn't be much to do provided you have the
PCMCIA interface connected correctly.

There was a mistake in the Motorola manual on the MPC850. It involved
two lines having to be swapped.

Conn

--

*****************************************************************
  If you live at home long enough, your parents will move out.
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
