Date: Mon, 9 Apr 2001 18:32:34 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
Cc: Guillaume Laures <guillaume.laures@noos.fr>,
	linuxppc <linuxppc-dev@lists.linuxppc.org>
Subject: Re: XFree86-4.0.99.2
In-Reply-To: <3AD16EB0.738E278E@iiic.ethz.ch>
Message-ID: <Pine.LNX.4.30.0104091831250.5912-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > #7  0x1003c6ec in xf86SigHandler ()
> > #8  <signal handler called>
> > #9  0x1030aa04 in ?? ()
> > #10 0x0 in ?? ()
>
> I suppose #0-#2 are from glibc and not interesting.
>
> The interesting parts are #9 and #10, which are probably in loadable modules

#10 looks particularly interesting. NULL pointer somewhere in the module
functions table?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
