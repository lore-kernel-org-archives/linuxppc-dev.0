Subject: Re: Heretical Question
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
To: Kent Borg <kentborg@borg.org>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20030709155723.G20807@borg.org>
References: <20030709155723.G20807@borg.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: 09 Jul 2003 22:53:15 +0200
Message-Id: <1057783996.3430.275.camel@spawn>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
