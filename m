Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: dc* (Data Cache)  instructions in mem*() and *_page() functions not used on 8xx
Date: Fri, 1 Nov 2002 12:14:50 +0100
Message-ID: <IGEFJKJNHJDCBKALBJLLAEIPFHAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <IGEFJKJNHJDCBKALBJLLMEHJFHAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > Joakim Tjernlund wrote:
> >
> > > It seems that even the newest 8xx chips still has problems. I did not expect that.
> >
> > It may be the parts are working fine.  I long ago removed the code necessary
> > to detect the exception conditions when the cache instructions faulted, so
> > I wouldn't expect them to work properly.
>
> Aah, that would explain why __copy_tofrom_user doesn't work I guess. But the
> rest seems to be fine. Maybe there should be a new config option that
> would one could enable for modern 8xx CPUs? With a big warning sign of cource
> and default to off. Maybe even add the missing exception handler?
>
>    Jocke

Dan, could you add the missing code for 8xx to detect the exception conditions when
the cache instructions faulted? I would like to give it a try.

Maybe add a new CONFIG option to allow 8xx to use these optimizations when
explicitly enabled. Perhaps it's enough to let it depend on CONFIG_8xx_CPU6, that is,
if CONFIG_8xx_CPU6 is set do NOT enable dcbz et. all, otherwise enable them?

        Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
