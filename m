From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: anthony tong <atong@uiuc.edu>, Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: [linux-fbdev] Re: Fwd: Re: still no accelerated X ($#!$*)
Date: Sat, 22 Jan 2000 21:44:52 -0500
Content-Type: text/plain
Cc: khendricks@ivey.uwo.ca, linuxppc-dev@lists.linuxppc.org,
        linux-fbdev@vuser.vu.union.edu
References: <00012021232600.07340@localhost.localdomain> <20000121151511.029555@mailhost.mipsys.com> <20000122145451.A26894@rogue.genunix.net>
In-Reply-To: <20000122145451.A26894@rogue.genunix.net>
MIME-Version: 1.0
Message-Id: <00012221475102.00489@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Anthony,

> > I'll put back eieio() in the access macros for my kernels until a
> > definitive answer pops up on this issue.
>
> I must have missed when these were taken out; does anyone know the reason
> why it was done?

When the eieio's in aty128fb.c have been added back in to the version that was
backported to 2.2.14 please cc a copy of the file you send to Ben to me also.
I am still having trouble debugging some final nits in the xf 3.9.17 r128
module and would love to have a "fixed" driver.

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
