Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Ajay Jain <ajay050@gmail.com>
Subject: Re: Linux Priority Levels
In-reply-to: <b92b327b1003152106l4027ae6djb238fa5cdcd29810@mail.gmail.com>
References: <b92b327b1003152106l4027ae6djb238fa5cdcd29810@mail.gmail.com>
Date: Mon, 15 Mar 2010 23:22:23 -0500
Message-ID: <9294.1268713343@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I need a deeper understanding of priorities of linux processes and
> threads, especially on Linux PPC. I have done some good reading, but
> found no material to be complete and therefore I am raising a few
> questions below.
> 
> 1) In Linux processes have a static priority level 0, with nice values
> -20 to +19. Then it has RT priority levels 1 - 99. My question is, do
> the nice values apply to all processes or do they apply only to
> priority 0?
> 
> 2) How many total priority levels does the kernel have? On one hand,
> -20 is the highest priority, on the other hand +99 is the highest. How
> do these values converge?
> 
> Please help me to answer these and depending on the reply I would
> shoot more questions. In case you have a comprehensive reading
> material to refer, please advise.

man sched_setscheduler has a good description of these levels and how RT
and non RT processes interact.

Mikey
