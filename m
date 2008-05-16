Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id F13B3DDED7
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 21:21:41 +1000 (EST)
Date: Fri, 16 May 2008 15:21:38 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [RFC PATCH 0/3] Board-specific PCI fixups [was: Re: [PATCH
	2/2] [POWERPC] 86xx: mpc8610_hpcd: add support for ULI RTC]
Message-ID: <20080516112138.GA29124@polina.dev.rtsoft.ru>
References: <20080508142005.GA6749@polina.dev.rtsoft.ru>
	<20080515162048.GA28559@polina.dev.rtsoft.ru>
	<20080516095027.303bb30e.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080516095027.303bb30e.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 16, 2008 at 09:50:27AM +1000, Stephen Rothwell wrote:
> Hi Anton,
> 
> This is not me picking on you, I just want to make a general statement.
> 
> On Thu, 15 May 2008 20:20:48 +0400 Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> >
> > Could we then apply this to the powerpc-next for proper testing?
> 
> We should not do this.  powerpc-next feeds into linux-next which is for
> inter subsystem integration testing.  Architecture specific testing
> should be done before things get to -next.

Oh.

> I am hoping that Paul will run a separate powerpc tree/branch for powerpc
> wide testing and then migrate stuff form there to powerpc-next when he is
> happy that things are as good as we can get.  This does not mean
> "perfect". :-)

Yeah, that would be great.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
