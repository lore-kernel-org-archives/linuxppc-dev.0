Date: Mon, 19 Jul 1999 23:07:33 +0200
To: Matt Porter <mmporter@home.com>
Cc: VALETTE Eric <valette@crf.canon.fr>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Is the vger 2.2 kernel branch dead
Message-ID: <19990719230733.X25323@isis.isis.de>
References: <m116DdY-0000WZC@tri-yann.crf.canon.fr> <Pine.LNX.3.96.990719133758.6567C-100000@liberty.chnd1.az.home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.3.96.990719133758.6567C-100000@liberty.chnd1.az.home.com>; from Matt Porter on Mon, Jul 19, 1999 at 01:39:05PM -0700
From: Hartmut.Koptein@t-online.de (Hartmut Koptein)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > I tried to upgrade here and no changes during one month!!!
> > As there still some important bugs in 2.2.10++, I wonder
> > why nothing happens???
> 
> Perhaps nobody has submitted any bug fixes?

Btw: what is the status for the SHM bug? Can we easiely push it up to 16MB?

/usr/src/linux/include/asm/shmparam.h

#define SHMMAX 0x1000000                /* max shared seg size (bytes) */


Another problem is the missing  set_bit, clear_bit, ... in /usr/include/asm/bitops.h

This is ifdefed with   #if 0 ... #endif


Regards,


       Hartmut

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
