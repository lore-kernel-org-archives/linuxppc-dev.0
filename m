MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Summary: Question on the fs choice (long)
Date: Thu, 20 May 2004 10:49:18 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DADC@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Also make sure that the CPU reset signal is held low long enough after
power resumes so that it wont interfere if the power failure is less
than 100ms (or whatever the CF card needs to finish what it is doing)
(so make power-on-reset equal to 100ms...)

> Regarding the hardware protection of flash chips on
> power-down:  There's a circuit we used to use to protect
> battery-backed RAM from this problem.  The basic technique is
> to hold the CS high when the power falls below a certain
> value.  See maxim-ic.com for chips that do this.  I think for
> flash substituting a capacitor for the battery would
> implement a similar function.
>
> Just an idea, I don't know if anyone's actually tried it with flash...
>
> Mark Chambers
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
