Return-Path: <marvin24@gmx.de>
From: marvin <marvin24@gmx.de>
To: michael@ellerman.id.au
Subject: Re: lockup during powersave on G3
Date: Wed, 2 Aug 2006 20:31:01 +0200
References: <200608020747.50765.marvin24@gmx.de>
	<1154510480.26242.18.camel@localhost.localdomain>
In-Reply-To: <1154510480.26242.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200608022031.01570.marvin24@gmx.de>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


arrrr,

the lastest pull seems to have fixed the problem.

Le Wednesday 2 August 2006 11:21, Michael Ellerman a =C3=A9crit :
> On Wed, 2006-08-02 at 07:47 +0200, marvin wrote:
> > hi,
> >
> > since kernel 2.6.18-rc1 my b/w G3 mac locks up every time it goes into
> > powersave mode. Before trying to bisect, is there a candidate I can try
> > to revert?
>
> By "since" do you mean 2.6.18-rc1 worked and it's broken since then, or
> that something earlier worked and it's broken starting from 2.6.18-rc1?
>
> Ben's new irq stuff might be a candidate, that was a pretty big change.

commit 49b1e3ea19b1c95c2f012b8331ffb3b169e4c042
	...
      [POWERPC] Fix new interrupt code (MPIC detection)
      [POWERPC] Fix new interrupt code (MPIC endianness)
	...

could be the reason.

thanks!

marc
