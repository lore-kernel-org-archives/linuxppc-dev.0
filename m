Message-ID: <20040201000247.9959.qmail@web11001.mail.yahoo.com>
Date: Sat, 31 Jan 2004 16:02:47 -0800 (PST)
From: Xupei Liang <tliang@yahoo.com>
Subject: Re: IDE status timeout
To: Tord Andersson <tordson@algonet.se>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <021d01c3e6aa$f370f180$0280a8c0@emil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, Tord,

Thank you. The timing looks fine. The system is
working except that this problem happens very
intermittently.

Regards,

Terry Liang

--- Tord Andersson <tordson@algonet.se> wrote:
> Hi,
>
> Have you checked the WR, RD and CS timing against
> the CF spec. For some hardware setups you might need
> to
> add some wait states. (That's what made my system
> work).
>
> Kind regards,
>
> Tord
>
> ----- Original Message -----
> From: "Xupei Liang" <tliang@yahoo.com>
> To: <linuxppc-embedded@lists.linuxppc.org>
> Sent: Wednesday, January 28, 2004 7:13 AM
> Subject: IDE status timeout
>
>
> >
> > Hi,
> >
> > I have a customed board that is running Linux
> 2.4.19
> > and XFS and that has a compactFlash card. The
> > compactFlash card is running in true IDE mode. I
> ran
> > into the following error once in a while. It is
> very
> > difficult to reproduce.
> >
> > >hda: status timeout: status=0xd0 { Busy }
> > >hda: no DRQ after issuing WRITE
> > >ide0: reset timed-out, status=0x80
> > >hda: status timeout: status=0x80 { Busy }
> > >hda: drive not ready for command
> > >ide0: reset timed-out, status=0x80
> > >end_request: I/O error, dev 03:02 (hda), sector
> 71472
> >
> > >end_request: I/O error, dev 03:02 (hda), sector
> 71480
> >
> > >end_request: I/O error, dev 03:02 (hda), sector
> 77264
> >
> > >end_request: I/O error, dev 03:02 (hda), sector
> 77272
> >
> > >end_request: I/O error, dev 03:02 (hda), sector
> > 115537
> > >I/O error in filesystem ("ide0(3,2)") meta-data
> dev
> > 0x302 block 0x1c351
> > >
> >
> > I read some discussions on a similar (or same?)
> > problem in another forum.
> >
> >
>
http://www.ussg.iu.edu/hypermail/linux/kernel/0312.3/index.html#1111
> >
> > But my problem seems to be different because even
> a
> > soft reset can not reset the card and the problem
> > happens very randomly. The compactFlash card seems
> to
> > be stuck. Has anybody seen this problem before?
> >
> > Thank you in advanced for your input.
> >
> > Regards,
> >
> > Terry Liang
> >
> >
> >
> >
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
