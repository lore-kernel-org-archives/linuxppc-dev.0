From: "Rick Hunnicutt" <rhunnicu@getntds.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: GDB/GDBSERVER and remote Thread Debugging
Date: Thu, 6 Jun 2002 08:43:26 -0700
Message-ID: <000a01c20d70$e66e9420$cdf859c7@get.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-reply-to: <3CFF7C68.C6151B82@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Will this give thread debugging with GDBSERVER as well or does it still have
to be native GDB?

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Mark
> Hatle
> Sent: Thursday, June 06, 2002 8:15 AM
> To: Steffen Rumler
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: GDB/GDBSERVER and remote Thread Debugging
>
>
>
> You will need to be working with GDB version 5.2 or newer to do thread
> debugging.
>
> --Mark
>
> Steffen Rumler wrote:
> >
> > Hello,
> >
> > I'm looking for a stable GDB/GDBSERVER extension
> > suitable for (remote) Debugging multiple threads.
> >
> > It should also possible to attach already running
> > threads.
> >
> > Actually I'm working with the GDB 5.0, but
> > I have problems with it. Sometimes breakpoints
> > are not hit, sometimes all threads seem to
> > be hanging in the debugging case only.
> >
> > Is there a stable extension for the GDB/GDBSERVER
> > providing thread debugging ?
> >
> > Thank you for help
> >
> > Steffen Rumler
> >
> > --
> >
> > --------------------------------------------------------------
> >
> > Steffen Rumler
> > ICN ON PNE SB 4
> > Siemens AG
> > Hofmannstr. 51                 Email: Steffen.Rumler@icn.siemens.de
> > D-81359 Munich                 Phone: +49 89 722-44061
> > Germany                        Fax  : +49 89 722-36703
> >
> > --------------------------------------------------------------
> >
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
