From: Josh Huber <huberj@WPI.EDU>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14191.55517.487990.159275@cpu.WPI.EDU>
Date: Tue, 22 Jun 1999 14:41:33 -0400 (EDT)
To: Joseph Palani Garcia <jpgarcia@execpc.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: preferred Sync rates in X for PDQ/Wallstreet 2.0
In-Reply-To: <Pine.GSO.3.95.990622132502.21035A-100000@earth>
References: <Pine.GSO.3.95.990622132502.21035A-100000@earth>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Joseph Palani Garcia writes:
> 
> Does anyone know the preferred HorzSync and VertRefresh rates for the LCD
> display on a PBG3/300?
> 
> Xconfigutator either has outrageous rates or there just aren't vid modes
> that do it.  I know LCD's don't really have a sync rate, but I'd like to
> think it is compatible with something better than the 60/31.5-48.5 that I
> am stuck using from the generic LCD settings.  Or does it matter?  i
> have noticed that some GTK apps (e-conf and gterm) take a bit to draw
> themselfs before they open.  related issue?  (a vid mode at a higher rate 
> i had "working" was weird in that about half the screen was offset half a
> pixel so it looked like antialiased interlacing. best description i can
> think of :)
I suggest inserting the output of fbset -x into your XF86Config file.  This has sane values, and works (on my PB233 14.1") nicely.

Josh

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
