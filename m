Message-ID: <C08678384BE7D311B4D70004ACA371050B7632EE@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'Neil Horman'" <nhorman@lvl7.com>,
	Mark Pilon <mpilon@midrivers.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: how to enable core files ?
Date: Tue, 26 Feb 2002 14:33:20 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You might also check the setrlimit(2) manpage, which includes
the relevant C library routine.


-----Original Message-----
From: Neil Horman [mailto:nhorman@lvl7.com]
Sent: Tuesday, February 26, 2002 1:58 PM
To: Mark Pilon
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: how to enable core files ?



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
under bash and found that we could create core files with the following
command:
ulimit -c <size> OR 'unlimited'
Its a built in bash command, so the implementation may vary if you are
running a
different shell.  For what its worth though, hope that helps!
Neil


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
