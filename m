Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yJkq44QyqzDqXv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Oct 2017 12:00:16 +1100 (AEDT)
Message-ID: <1508547615.23934.6.camel@neuling.org>
Subject: Re: [PATCH 1/4] powerpc/tm: Add commandline option to disable
 hardware transactional memory
From: Michael Neuling <mikey@neuling.org>
To: David Laight <David.Laight@ACULAB.COM>, 'Breno Leitao'
 <leitao@debian.org>,  Michael Ellerman <mpe@ellerman.id.au>
Cc: "stewart@linux.vnet.ibm.com" <stewart@linux.vnet.ibm.com>,
 "linuxppc-dev@ozlabs.org"
 <linuxppc-dev@ozlabs.org>, "cyrilbur@gmail.com" <cyrilbur@gmail.com>
Date: Sat, 21 Oct 2017 12:00:15 +1100
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD009D7D7@AcuExch.aculab.com>
References: <1507803439-12862-1-git-send-email-mpe@ellerman.id.au>
 <20171020114539.piyh4wmby5gz7qnb@gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6DD009D7D7@AcuExch.aculab.com>
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

On Fri, 2017-10-20 at 12:58 +0000, David Laight wrote:
> > > This patch adds a simple commandline option so that HTM can be
> > > disabled at boot time.
>=20
> ISTM that being able to disable it after boot would be more useful.
> (ie in a startup script)

I agree bug unfortunately that's impossible.

If a process is already running in tm suspend, there is no way to stop it o=
ther
than killing the process.  At that point you may as well kexec with a new
cmdline option

Mikey
