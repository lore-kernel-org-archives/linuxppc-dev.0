Date: Mon, 27 May 2002 09:14:49 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dross Zhou <zjuzhou@yahoo.com.cn>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: About 2.4.19 kernel(ppckernel.org)boot panic?
Message-ID: <20020527161449.GA32718@opus.bloom.county>
References: <20020527092321.38165.qmail@web15001.mail.bjs.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020527092321.38165.qmail@web15001.mail.bjs.yahoo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, May 27, 2002 at 05:23:21PM +0800, Dross Zhou wrote:

> 	I try to port linuxppc2.4.19-pre8(from
> www.ppckernel.org) to our borad from Rpxlite_config.
> But it panic after dump some information.
> Before porting 2.4.19 , I have porting 2.4.4(from
> denx.de) to my borad and it works well, I have done
> same work as what i have done with 2.4.4.
> What problem,it says 'kernel access of bad area, sig:
> 11 '

Just wondering, is your CPU old enough (and an MPC860) to need the CPU6
errata work-arounds?  That oops almost looks like the ones that are seen
when you need the CPU6 errata enabled but don't.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
