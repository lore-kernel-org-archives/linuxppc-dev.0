Date: Tue, 9 Jan 2001 23:28:33 +0100 (MET)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: Andreas Tobler <toa@pop.agri.ch>
cc: Linux PPC Developer Mailing List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: status of ppc support in official 2.4.0 or Alan's 2.4.0-ac1
In-Reply-To: <3A59C65F.D92C79E8@pop.agri.ch>
Message-ID: <Pine.SOL.3.95.1010109231443.18965B-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 8 Jan 2001, Andreas Tobler wrote:

> Hallo Derek,
>
> ich bin gerade in der Hetz, schau mal unter lists.linuxppc.org dev
> Stichwort ppp.
>
> Soweit ich mich erinnere brauchst Du das ppp-2.4.0 packet.
> ftp.linuxcare.com.au/pub/ppp
>
> > [...]
> > Jan  7 22:27:11 miranda chat[836]: CONNECT
> > Jan  7 22:27:11 miranda chat[836]:  -- got it
> > Jan  7 22:27:11 miranda chat[836]: send (^M)
> > Jan  7 22:27:11 miranda pppd[834]: Serial connection established.
> > Jan  7 22:27:11 miranda pppd[834]: Using interface ppp0
> > Jan  7 22:27:11 miranda pppd[834]: Connect: ppp0 <--> /dev/ttyS0
> > Jan  7 22:27:34 miranda pppd[834]: Hangup (SIGHUP)
> > Jan  7 22:27:40 miranda pppd[834]: Connection terminated.
> > Jan  7 22:27:40 miranda pppd[834]: tcflush failed: Eingabe-/Ausgabefehler
> > Jan  7 22:27:40 miranda chat[840]: Can't get terminal parameters: Eingabe-/Ausgabefehler
> > Jan  7 22:27:40 miranda pppd[834]: disconnect script failed
> > Jan  7 22:27:41 miranda pppd[834]: Exit.
> >
> > That last error means "I/O-error".
> > With 2.2 kernels, at this point the compression modules would be loaded:
> >
> > Jan  8 11:11:15 miranda pppd[694]: Connect: ppp0 <--> /dev/ttyS0
> > Jan  8 11:11:16 miranda kernel: PPP BSD Compression module registered
> > Jan  8 11:11:16 miranda kernel: PPP Deflate Compression module registered
> >
> > but under 2.4 they aren't loaded and neither do they seem to be missed:
> >
Jan  7 22:27:40 miranda pppd[834]: tcflush failed: Eingabe-/Ausgabefehler
Jan  7 22:27:40 miranda chat[840]: Can't get terminal parameters:
Eingabe-/Ausgabefehler
Jan  7 22:27:40 miranda pppd[834]: disconnect script failed

Thanks for the link, Andreas, but upgrading to ppp-2.4.0 did not solve
the whole  problem. Instead of the tcflush problem it terminates now
immediately (1-2 secs) after "Connect: ppp0 <--> /dev/ttyS0" with
"Hangup (SIGHUP)" and "Modem hangup".
The comression modules still aren't loaded.

Thanks,
							Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
