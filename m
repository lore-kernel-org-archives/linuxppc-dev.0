Message-ID: <3C598C41.8AC31B3C@midrivers.com>
Date: Thu, 31 Jan 2002 11:26:09 -0700
From: Mark Pilon <mpilon@midrivers.com>
MIME-Version: 1.0
To: Armin Kuster <akuster@mvista.com>
Cc: David =?iso-8859-1?Q?M=FCller?= (ELSOFT AG) <d.mueller@elsoft.ch>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] 3 patches against linuxppc_dev-2.4.18-pre7
References: <3C57F9AC.9040008@elsoft.ch> <3C58410B.802BC1F4@mvista.com> <3C59005A.4080400@elsoft.ch> <3C5989D2.3F77685@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> >
> > In ppc405_pic_get_irq() the following code is executed:
> >
> >         irq = 32 - ffs(bits);
> >
> >         if (irq == NR_IRQS)
> >                 irq = -1;
> >
> >         return(irq);
> >
> > with NR_IRQS equal 48 the condition is never true !
> >


You might check the actual code generated for ffs() and verify
it works -- I ended up recoding this routine because ffs() wasn't
working correctly ... [ I forget the particulars, but the code
generated and behavior were not correct ];

Mark
--
Mark Pilon

Minolta-QMS
P.O. Box 37
Fallon, MT.  59326-0037
1-406-486-5539 (primary voice line)
1-406-853-0433 (cell)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
