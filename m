Subject: Re: linuxppc-embedded: main kernel tree
To: dan@netx4.com (Dan Malek)
Date: Thu, 27 Jan 2000 11:45:24 +1100 (EST)
Cc: alan@packetengines.com (Alan Mimms),
        linuxppc-embedded@lists.linuxppc.org (linuxppc-embedded)
In-Reply-To: <388F677E.59321B87@netx4.com> from "Dan Malek" at Jan 26, 2000 04:30:38 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000127004524.3F1A519933@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek writes:
> Alan Mimms wrote:
>
> > Thank you.  However, since I started out with the 2.2.13 sources and found
> > they just didn't work really at all on the CLLF
>
>
> Huh?  They should.  The only bug was the FEC driver.

There were also changes to arch/ppc/kernel/head.S required to get 2.2.13 from
ftp.ppc.kernel.org. to work on the CLLF boards.

Alan, in case you aren't aware, these changes are included in the kit at:
    ftp://mail.netx4.com/pub/cllf-2.2.13.tgz

This should be your starting point if you wish to switch to 2.2.x on the
CLLF's.

> Of course not.  I sometimes wonder why I bother posting messages
> and writing development notes......The 2.2.xx kernels do not have
> any up to date 8xx functions.  You must use the tar files from
> ppc.kernel.org that I have updated......

Well, I for one am particularly glad you do -- I sure read 'em!  I try to
point others to them too; most newcomers don't realise that you've already
answered their question before they ask...

Regards,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
