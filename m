MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: SDRAM is finally working
Date: Mon, 15 Apr 2002 14:07:11 -0500
Message-ID: <D3A72C5007329A4F991C0DD87202259F096B00@sekhmet.ad.newisys.com>
From: "Navin Boppuri" <navin.boppuri@newisys.com>
To: "Jin Cheng" <jcheng@redswitch.com>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


http://e-www.motorola.com/webapp/sps/site/prod_summary.jsp?code=MPC860&nodeId=01M0ypBDKCb

Go to this link and search for MCUINIT. You can download the tool form here.

Navin

-----Original Message-----
From: Jin Cheng [mailto:jcheng@redswitch.com]
Sent: Monday, April 15, 2002 2:01 PM
To: Kerl, John
Cc: 'Donald White'; Navin Boppuri; Linuxppc-Embedded (E-mail)
Subject: Re: SDRAM is finally working


Hi,

Can anyone email me a copy of mcuinit.exe? I am very appreciated.

Sincerely,

Jin Cheng

"Kerl, John" wrote:

> We have used a tool called:
>
>         mcuinit.exe
>
> This is available from the Motorola web site (sorry, I don't
> know the URL).  It is a very nice GUI in which you twiddle
> high and low values in waveforms (you see the waveforms change
> before your eyes), and you try to get them to look like the
> waveforms in your SDRAM vendor's data sheet.  & it generates
> the magic UPM numbers which cause the UPM to generate those
> waveforms at run time.
>
> -----Original Message-----
> From: Donald White [mailto:dbwhite@asu.edu]
> Sent: Wednesday, February 20, 2002 5:41 PM
> To: Navin Boppuri
> Cc: Linuxppc-Embedded (E-mail)
> Subject: Re: SDRAM is finally working
>
> Navin,
>
> While I have no right to ask, could you provide a tutorial on how one
> goes from the SDRAM chip specifications to the UPM words?
>
> I did a port of HHL 2.0 to an 860 board and never felt I really
> understood the SDRAM initialization.  The board manufacturer provided a
> set of UPM words.  These had been used by a previous vxWorks port.  But
> burst mode never worked right for either and I was never confident that
> the UPM words were right.
>
> Thanks,
>
> Don
>
> Navin Boppuri wrote:
> >
> > I now have Linux kernel booting up and mounting a file system without
> >any problems. I had all the timing right but my SDRAM initialization
> >was messed up. My init sequence was missing a single NOP command at
> >the very start. And so, things worked fine with PPCBOOT but with more
> >memory intensive stuff that the kernel does, I had software emulation
> >errors during the kernel boot.
> >
> > I appreciate all the help from Wolfgang in doing this. I got my very
> >first SDRAM interface working on the 855 processor.
> >
> > I would like to point out to everyone in this mailing list that there
> >is an App. Note from Motorola (ANxxx/D) that talks about a high speed
> >SDRAM interface to the MPC823. The document is a good start for anyone
> >trying to interface the 8xx processor to and SDRAM while running the
> >bus at speeds greater than 50Mhz. But please NOTE that the timings
> >shown in the example SDRAM interface in this App. Note for the Micron
> >MT48LC* chip are very wrong. Please do not design your timing around
> >this example.
> >
> > I looked at the sample timings from various board supports in PPCBOOT
> >(eg. hermes). I manually inserted these timings into an *.mgp file for
> >the MCUinit utility and looked at them in the GUI interface. But the
> >final timings are totally dependent on your particular SDRAM chip ( The
> >fact which Wolfgang tells us about all the time ;) ).
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
