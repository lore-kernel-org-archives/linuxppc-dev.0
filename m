Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
Message-ID: <XFMail.990308075819.hcaley@loomer.com>
In-Reply-To: <199903080559.XAA25812@lists.linuxppc.org>
Date: Mon, 08 Mar 1999 07:58:36 -0500 (EST)
From: Batmensch <hcaley@loomer.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: RE: PBG3Series and pre-R5:a lot further
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I tried this XF86Config on my PB G3 Series, and although it starts up, it is
still running in Open Firmware (non-accelerated mode).

Did you try running fbset -i while the Xserver is up?

I could be wrong, but it seems to me I remember reading somewhere that you
can't run XF68_FBDev in accelerated mode when the console is running Ofb.

Xpmac is much faster than Ofb; try moving an open window around.

Hugh

On 08-Mar-99 Linux PPC Developer Digest wrote:
> Date: Sun, 07 Mar 1999 23:17:48 +0100
> From: "G. =?iso-8859-1?Q?Laur=E8s?=" <laures@hp1.esiea.fr>
> Subject: Re: PBG3Series and pre-R5: a lot further
> 
> Finally, I got it !
> XFBDev on PBG3 series, now the TFT screams ! I never though it would be
> that good.
> 
> So it turns out that it was the lack of valid video mode that prevented
> XFBDev to work properly (actually, to display properly). Now I have the
> following /etc/XF86Config :
> 
># /etc/XF86Config
># makes XF68_FBDev emulate Xpmac by using the current video mode
># and the mac mouse. be sure to compile macintosh mouse
># support into your kernel and to create /dev/adbmouse.
># major=10 minor=10
># (Courtesy Brad Midgley <brad@pht.com>)
> 
> Section "Files"

----------------------------------
E-Mail: Batmensch <hcaley@loomer.com>
Date: 08-Mar-99
Time: 07:51:55

This message was sent by XFMail
----------------------------------

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
