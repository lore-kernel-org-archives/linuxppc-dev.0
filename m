Message-ID: <390085CD.5A5E39ED@embeddededge.com>
Date: Fri, 21 Apr 2000 12:46:05 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: ipv6@263.net
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: whats wrong with ifconfig?
References: <008601becb11$9b48e1c0$57c809c0@nt4srv87>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


ipv6@263.net wrote:

> my custom 860 board boot ok,
> but in bash prompt
> I got these:
>
> init-2.00# /sbin/ifconfig eth0 192.9.200.81
> 192.9.200.81: Resolver Error 0 (no error)

> some thing wrong with my kernel?

No, it is a combination of configuration files in /etc, the
libraries and the program.  I wish I knew how to both reproduce and
fix this error because I have some systems that work and others that
don't.  I just get lost among the dynamic libraries that are
supposed to map (or not) depending upon the configuration files.

I suggest visiting the MontaVista ftp site, ftp.mvista.com, tracking
down the CDK 1.0 for the 8xx and loading those RPMs.  That is a
consistent set of programs, libraries, and configurations that work.


	-- Dan

> or just shell command lines
>
> Hope someone can help.
>
> thank you
>
> Regards.
> john zhan.
> hacking time.
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
