Message-ID: <D73A25AA6E54D511AD74009027B1110F3C0928@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'Kenneth Johansson'" <kenneth.johansson@etx.ericsson.se>,
	Kent Borg <kentborg@borg.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Heretical Question
Date: Wed, 9 Jul 2003 17:00:00 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've used insight on cygwin with an Abatron BDI 2000.  It seemed to work ok.

-----Original Message-----
From: Kenneth Johansson [mailto:kenneth.johansson@etx.ericsson.se]
Sent: Wednesday, July 09, 2003 4:53 PM
To: Kent Borg
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Heretical Question



On Wed, 2003-07-09 at 21:57, Kent Borg wrote:
>
> I know it is wrong for me to ask, but is there (possibly already
> lurking in my Red Hat box?) a graphical front end to GDB that will
> work with embedded programming?  Emacs already lets me debug with
> source code pretty well (not assembly, however), and that is nice, but
> what I really miss is a way to browse through data structures.  Kdbg
> looks good, but it seems to be for native debugging only (though I
> might hack at it a little to issue the elusive "target remote ...").
> It is possible ddd would do, but it also seems to be for native
> debugging only too.
>
> Suggestions?
>

http://sourceware.redhat.com/insight/

Never tried but since this is the old cygnus stuff it really should do
cross debugging well.


--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 719 70 20
Tellusborgsvägen  90              Fax: +46 8 719 29 45
126 25 Stockholm                  ken@switchboard.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
