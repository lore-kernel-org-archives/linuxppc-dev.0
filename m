Return-Path: <robin@india.tejasnetworks.com>
Received: from pop-mail.india.tejasnetworks.com (india.tejasnetworks.com
	[164.164.94.83]) by ozlabs.org (Postfix) with SMTP id 5AFBF67A65
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Feb 2005 17:29:44 +1100 (EST)
Content-Type: text/plain;
  charset="iso-8859-1"
From: robin <robin@india.tejasnetworks.com>
To: Gerhard Jaeger <g.jaeger@sysgo.com>,
	linuxppc-embedded@ozlabs.org, etux@embeddedtux.org
Date: Fri, 11 Feb 2005 11:59:04 +0530
References: <20050204192117.4F29CC108D@atlas.denx.de>
	<200502101137.07711.robin@india.tejasnetworks.com>
	<200502100840.38232.g.jaeger@sysgo.com>
In-Reply-To: <200502100840.38232.g.jaeger@sysgo.com>
MIME-Version: 1.0
Message-Id: <200502111159.04265.robin@india.tejasnetworks.com>
Subject: Memory leak problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi=20
Thanks for your help.=20

We found the memory leak in the syncppp module in linux.

1. Did somebody encounter any problems(leaks) with the=20
syncppp module in denx 2.4.20 kernel??=20

2. Are there any known issues with this module??

The scenario is we are ftp-ing continuosly between=20
two nodes using syncppp module. The leak is ocuring at=20
both the nodes.

Regards,
Robin



On Thursday 10 Feb 2005 1:10 pm, Gerhard Jaeger wrote:
> On Thursday 10 February 2005 07:07, robin wrote:
> > Hi
> > We have an application running on  denx linux kernel 2.4.20.
> >
> > Apparently there is a memory leak that we are not able to find.
> > The application is giving out of memory error. Even if we restart
> > the application without rebooting the kernel, (killing all applicatio=
n
> > processes and restarting), it gives the same out of memory error.
> > Rebooting the kernel solves the problem.
> >
> > It seems that the memory leak is not at the application level
> > 'cos restarting the application doesnt solve the problem..
> >
> > 1. Any ideas where I should look for the leak??
>
> Check /proc/slabinfo and see if there are some "supicious" buffer,
> that only increase and never decrease. From the kind of buffer
> showing this behaviour you might find out where to dig...
> Check it before running the application and afterwards.
>
> > 2. Is there any known memory leak problems with the kernel??
>
> There are enough places, where a kernel could leak, but in general
> such leaks in the main part are detected really fast. Undiscovered
> leaks are often found in the drivers itself.
>
> What's your kernel config?
> Which HW are you using?
> What does this application?
>
> Ciao,
> Gerhard

--=20
And I hate redundancy, and having different functions for the same thing.

=09- Linus Torvalds on linux-kernel
