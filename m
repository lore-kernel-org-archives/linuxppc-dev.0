Date: Mon, 6 Nov 2000 18:38:37 +1100
From: Chris Leishman <masklin@debian.org>
To: Rod Stewart <stewart@lab43.org>
Cc: Chris Leishman <masklin@debian.org>, linuxppc-dev@lists.linuxppc.org
Subject: Airport debug (was Re: airport woes?)
Message-ID: <20001106183837.A5039@nina.dev.fol>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Nov 02, 2000 at 03:15:58PM -0500, Rod Stewart wrote:
<snip>
>
> Anyone know if this is fixed, or a work around?  I've got the same setup,
> with the same problem.  My ssh connections over airport freeze.
>
> Thanks,
> -Rms

No idea yet - but I'm not all the familiar with device drivers, etc, yet.

I do know that the airport_tx method stops getting called when the lock-up
occurs.  Why it doesn't get called I don't know.

Regards,

Chris


--
----------------------------------------------------------------------
       Knuth: premature optimization is the root of all evil.
----------------------------------------------------------------------
Reply with subject 'request key' for GPG public key.  KeyID 0xB4E24219

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
