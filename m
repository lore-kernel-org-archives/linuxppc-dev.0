Message-ID: <002501c2f266$3626e5a0$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Cc: "Tom Rini" <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>,
	<strauman@SLAC.Stanford.EDU>
References: <IGEFJKJNHJDCBKALBJLLEEGBFLAA.joakim.tjernlund@lumentis.se> <20030324201543.GB14264@ip68-0-152-218.tc.ph.cox.net> <003501c2f248$06ddc700$020120b0@jockeXP> <20030324210712.GC14264@ip68-0-152-218.tc.ph.cox.net> <005601c2f24f$f8e23e30$020120b0@jockeXP> <3E7F8DE4.1040901@embeddededge.com>
Subject: Re: dcbz works on 862 everywhere!
Date: Tue, 25 Mar 2003 01:33:47 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Joakim Tjernlund wrote:
>
> >
> > I think it makes the "copy DAR to MD_EPN" part in the DTLB error handler needless.
> > Anyway it works with and without that part.
>
> No, you need to leave that there as well.  Read the comment.....
>
> If it appears to "work" for you, what happens is you have a DTLB Error
> immediately following a DTLB miss (the common case lots of the time), so
> the MD_EPN just happens to contain the proper information.  When you generate
> the case where a DTLB Error does not match a previous DTLB miss, you will
> end up tracking down the wrong PTEs.  Even in this case it is likely to
> appear things work correctly, but they do not.  There is one case with the dcbi
> where there is no proper operation of the code, so it was necessary to solve
> the problem another way.

What case is that(when dcbi does not work)? Give me an example so I can test
and see what happens, with and without my patch.

> This is exactly why people are telling you to carefully generate test cases
> the prove an error exists 100% of the time, and that your modifications
> properly correct the condition 100% of the time.  When you run something
> like Linux you get pathological cases that do not exercise all conditions
> with a particular configurations, or you could be generating errors that
> are not precisely tested as failure conditions.

I know all that and thats why post to the list with questions, ideas  and  patches to try out.
If you had read my mails you would had understood that too.
Your yelling at me for trying isn't very helpful.

    Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
