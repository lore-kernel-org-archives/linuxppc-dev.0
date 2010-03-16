Return-Path: <ajay050@gmail.com>
Received: from mail-fx0-f227.google.com (mail-fx0-f227.google.com
	[209.85.220.227]) by ozlabs.org (Postfix) with ESMTP id 37793B7DA3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Mar 2010 15:06:59 +1100 (EST)
Received: by fxm27 with SMTP id 27so140553fxm.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Mar 2010 21:06:57 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 16 Mar 2010 09:36:56 +0530
Message-ID: <b92b327b1003152106l4027ae6djb238fa5cdcd29810@mail.gmail.com>
Subject: Linux Priority Levels
From: Ajay Jain <ajay050@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I need a deeper understanding of priorities of linux processes and
threads, especially on Linux PPC. I have done some good reading, but
found no material to be complete and therefore I am raising a few
questions below.

1) In Linux processes have a static priority level 0, with nice values
-20 to +19. Then it has RT priority levels 1 - 99. My question is, do
the nice values apply to all processes or do they apply only to
priority 0?

2) How many total priority levels does the kernel have? On one hand,
-20 is the highest priority, on the other hand +99 is the highest. How
do these values converge?

Please help me to answer these and depending on the reply I would
shoot more questions. In case you have a comprehensive reading
material to refer, please advise.

Thanks,
Ajay.
