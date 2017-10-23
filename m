Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yL9jd1jJLzDqfw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 20:15:33 +1100 (AEDT)
Message-ID: <1508750132.28823.12.camel@neuling.org>
Subject: Re: [PATCH 1/4] powerpc/tm: Add commandline option to disable
 hardware transactional memory
From: Michael Neuling <mikey@neuling.org>
To: David Laight <David.Laight@ACULAB.COM>, 'Breno Leitao'
 <leitao@debian.org>,  Michael Ellerman <mpe@ellerman.id.au>
Cc: "stewart@linux.vnet.ibm.com" <stewart@linux.vnet.ibm.com>,
 "linuxppc-dev@ozlabs.org"
 <linuxppc-dev@ozlabs.org>, "cyrilbur@gmail.com" <cyrilbur@gmail.com>
Date: Mon, 23 Oct 2017 20:15:32 +1100
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD009F052@AcuExch.aculab.com>
References: <1507803439-12862-1-git-send-email-mpe@ellerman.id.au>
 <20171020114539.piyh4wmby5gz7qnb@gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6DD009D7D7@AcuExch.aculab.com>
 <1508547615.23934.6.camel@neuling.org>
 <063D6719AE5E284EB5DD2968C1650D6DD009F052@AcuExch.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-10-23 at 09:01 +0000, David Laight wrote:
> From: Michael Neuling
> > Sent: 21 October 2017 02:00
> > To: David Laight; 'Breno Leitao'; Michael Ellerman
> > Cc: stewart@linux.vnet.ibm.com; linuxppc-dev@ozlabs.org; cyrilbur@gmail=
.com
> > Subject: Re: [PATCH 1/4] powerpc/tm: Add commandline option to disable
> > hardware transactional memory
> >=20
> > On Fri, 2017-10-20 at 12:58 +0000, David Laight wrote:
> > > > > This patch adds a simple commandline option so that HTM can be
> > > > > disabled at boot time.
> > >=20
> > > ISTM that being able to disable it after boot would be more useful.
> > > (ie in a startup script)
> >=20
> > I agree bug unfortunately that's impossible.
> >=20
> > If a process is already running in tm suspend, there is no way to stop =
it
> > other
> > than killing the process.  At that point you may as well kexec with a n=
ew
> > cmdline option
>=20
> Isn't that unlikely when the first rc scripts are being run?
> Setting an early rc script is generally easier than adding a command line
> parameter.

Unlikely or not, it's a case we'd have to handle that would add significant
complexity compared to what's being proposed for (IMHO) little gain.

Also, this doesn't exclude that option later if we decided we could do it.

> I don't know about ppc, but grub on x86 makes it painfully almost
> impossible to have two boot entries that have different command line
> options.

Ok.

Mikey
