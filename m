Date: Thu, 19 Dec 2002 12:03:24 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: Docs for the new style dpalloc/hostalloc patch.
In-reply-to: <3E01A1E6.1070905@intracom.gr>
To: Pantelis Antoniou <panto@intracom.gr>
Cc: linuxppc-embedded@lists.linuxppc.org
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLCEPEFIAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Joakim Tjernlund wrote:
>
> >Hi
> >
> >This looks good to me. It's only a bit big, but I guess that's the price one
> >has to pay. I haven't tested it yet though.
> >
> >    Jocke
> >
>
> Hi
>
> Yes unfortunately is too big, the complexity will pay off
> on the upcoming patches, that will allow to use every last bit
> of the dpram.
>
> Just enable the options when compiling.
> Every current driver that uses the old-style interface
> should work without a problem.
>
> I would be very interested to see them used your updated enet driver.

Works just fine on my board!

Anyone else testing this?

 Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
