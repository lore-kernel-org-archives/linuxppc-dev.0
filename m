Message-Id: <200101290141.RAA21010@mail.turbolinux.com>
Date: Mon, 29 Jan 2001 01:49:14 -0000
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: pmud monitoring temperature (Re: powerbook doubles)
From: Brad Midgley <brad@turbolinux.com>
Cc: djosg@mgu.bath.ac.uk
Reply-To: brad@turbolinux.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi,

> > yes, it can.
> > Someone posted a patch some time last year to get the info into the /proc
> > entry.  If that no longer applies it shouldn't be too difficult to update
> > it.

i reworked this patch to work with the current bk tree (argh. i just complained to iain that diffs
against a moving target were gross)

http://redcloud.uccs.edu/~bcmidgle/linux/

btw, it looks like troy wants the _{gs}et_THRM{123} macros changed to use some different macros,
but i'm not familiar with that stuff so i just reenabled the old macros.

> until we have proper heat control in the kernel, maybe pmud should monitor the temperature and
put
> the machine to sleep if it runs too hot.

i'm looking into this part.

btw, what is a dangerous temperature? with the bays empty and a housefan running nearby (ie
relatively cool) it is reporting 42c.

--
Brad
brad@turbolinux.com      http://www.turbolinux.com/~brad/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
