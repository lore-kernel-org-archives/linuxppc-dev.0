Date: Tue, 6 Jul 1999 13:54:24 -0700 (PDT)
From: Jonathan Moore <moore@eds.org>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Jason Haas <jhaas@madison-web.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Fwd: Macsbug conflict w/BootX?
In-Reply-To: <19990706222944.001895@mail.mipsys.com>
Message-ID: <Pine.LNX.3.96.990706133431.18599C-100000@zen.eds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	The computer is a 7500 with a 604e 120 upgrade card. This happens
even with all extenctions turned off. The boot x vertion is the 1.1
vertion from the R5 cd I reseaved last week and the os is 7.5.1. The
kernels that showed this
problime are the finle and with video driver form the same R5 cd. I am not
at home so I don't know the vertion of macsbug but it is serteanly
srevreal years old (most likley pre 1995). I don't think I have anny thing
funkey set up in macsbug but I might; I rilly only use it to try to
recover from applacation crasheses. The dealitals of the failular are that
after doing a small amount of file writes the systome lockes  up and when
after a reboot the systome complaines about files with sared blocks.

The os was installed using the mklinux installer becouse the redhat
linuxppc vertion would die with mesh errors farley quickly (possibaly
related error) and the x installer would refuse to swich keybord fosic
making it usless.

seance I have removed macsbug form the systome folder on the mac side I
have hade no problimes. The only othere problime I have hade is that the
kernel with video is 2.2.9 and not 2.2.6 and you provied no kernal mods or
systome map to 2.2.9.

-Jonathan


On Tue, 6 Jul 1999, Benjamin Herrenschmidt wrote:

> On Tue, Jul 6, 1999, Jason Haas <jhaas@madison-web.com> wrote:
> 
> >---------- Forwarded message ----------
> >Date: Mon, 05 Jul 1999 13:24:28 -0700
> >From: moore@eds.org
> >To: support@linuxppc.org
> >Subject: Nasty bug (data loss)
> >Resent-Date: Tue, 6 Jul 1999 12:58:59 -0500 (CDT)
> >Resent-From: <support@www.linuxppc.org>
> >Resent-To: Jason Haas <jhaas@www.linuxppc.org>
> >
> >    I have discuverd that mascbug is incompatabull with boot x using at
> >least kernels 2.2.6 and 2.2.9; I have tryed no otheres. If you boot
> >linux using bootx while macsbug is installed on you mac it will cause
> >linux to have bad writes to disc and will destroy you fs.
> 
> I don't think I ever booted a Mac without Macsbug for the past few years,
> so I don't think there is such an incompatibility. Are you sure you have
> the latest version of MB ? Also, check that you MB install don't have
> weird dcmd's (Macsbug external commands).
> 
> Some infos about your configuration may help me find out what's going on:
> kind of machine, expansion boards, disk controller, version of BootX, etc...
> 
> -- 
>            Perso. e-mail: <mailto:bh40@calva.net>
>            Work   e-mail: <mailto:benh@mipsys.com>
> BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>
> 
> 
> 
> 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
