Message-ID: <3C7BF6F4.CAD54451@lvl7.com>
Date: Tue, 26 Feb 2002 15:58:28 -0500
From: Neil Horman <nhorman@lvl7.com>
MIME-Version: 1.0
To: Mark Pilon <mpilon@midrivers.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: how to enable core files ?
References: <3C7BF0F5.A830D984@midrivers.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark Pilon wrote:
>
> That is, what do I have to set / enable / include on my target
> so that a core file will be created when an application SEGVs ?
>
> I'm running Wolfgang's SELF -- and really need to be able to poke
> at a core file when my app dies.
>
> thanks,
>
> Mark

I'm not erally familiar with SELF, but we had this same problem.  We running
under bash and found that we could create core files with the following command:
ulimit -c <size> OR 'unlimited'
Its a built in bash command, so the implementation may vary if you are running a
different shell.  For what its worth though, hope that helps!
Neil

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
