Date: Mon, 28 Apr 2003 15:44:39 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: BK Id header removals causes patch to fail!
In-reply-to: <IGEFJKJNHJDCBKALBJLLMEFBFMAA.joakim.tjernlund@lumentis.se>
To: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Cc: paulus@samba.org
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLCEFDFMAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I am trying to patch my linuxppc_2_4_devel tree, version 2.4.20 into linuxppc_2_4_devel current.
> I have generated patch with bk rset -h -r1.1174,1.1294 | bk gnupatch. When I try to apply
> that patch to my tree I get a lot of:
>
> patching file arch/ppc/kernel/setup.c
> Reversed (or previously applied) patch detected!  Assume -R? [n]
> Apply anyway? [n] y
> Hunk #1 FAILED at 4.
> Hunk #2 succeeded at 29 (offset -3 lines).
> Hunk #3 succeeded at 490 (offset 3 lines).
> Hunk #4 succeeded at 526 (offset 11 lines).
> Hunk #5 succeeded at 586 (offset 3 lines).
> Hunk #6 succeeded at 639 (offset 11 lines).
> 1 out of 6 hunks FAILED -- saving rejects to file arch/ppc/kernel/setup.c.rej
>
>
> As far as I can tell it is the BK Id removals that is causing this. How can I
> workaround this problem? Did I do something wrong?
>
> A typical BK Id in a file looks likes this:
>
> And in the patch it looks like this:
> /*
>  * BK Id: SCCS/s.setup.c 1.111 10/29/02 10:49:05 trini
>  */
>
> And the patch:
> @@ -1,7 +1,4 @@
>  /*
> - * BK Id: %F% %I% %G% %U% %#%
> - */
> -/*
>
>  Jocke

I can't find BK command/option which will fix this problem.
What was the rationale behind this pointless cleanup? I can understand if
you do this in 2.5 but why do it in 2.4?

Is there a way to fix this using BK?

 Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
