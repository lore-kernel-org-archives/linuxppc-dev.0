Return-Path: <glikely@secretlab.ca>
Received: from hs-out-2122.google.com (hs-out-0708.google.com [64.233.178.240])
	by ozlabs.org (Postfix) with ESMTP id C6915DDDFD
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 06:36:23 +1100 (EST)
Received: by hs-out-2122.google.com with SMTP id x43so2292849hsb.9
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jan 2008 11:36:22 -0800 (PST)
Message-ID: <fa686aa40801211136u7f25bc38u3ef99b5cc750d850@mail.gmail.com>
Date: Mon, 21 Jan 2008 12:36:21 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/2] [POWERPC] 8xxx and embedded6xx: Use
	machine_*_initcall() hooks in platform code
In-Reply-To: <fa686aa40801211135r5cde9f6t9b6ee323a48bc44c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080121185806.13486.56429.stgit@trillian.secretlab.ca>
	<20080121185812.13486.68032.stgit@trillian.secretlab.ca>
	<6FA7C7C0-172D-4AD4-BDAF-A1E3845A63FE@kernel.crashing.org>
	<fa686aa40801211135r5cde9f6t9b6ee323a48bc44c@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/21/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 1/21/08, Kumar Gala <galak@kernel.crashing.org> wrote:
> >
> > On Jan 21, 2008, at 12:58 PM, Grant Likely wrote:
> >
> > > From: Grant Likely <grant.likely@secretlab.ca>
> > >
> > > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> > > ---
> > >
> > > arch/powerpc/platforms/82xx/mpc8272_ads.c    |    5 +----
> > > arch/powerpc/platforms/82xx/pq2fads.c        |    5 +----
> > > arch/powerpc/platforms/83xx/mpc832x_mds.c    |    5 +----
> > > arch/powerpc/platforms/83xx/mpc832x_rdb.c    |   11 ++---------
> > > arch/powerpc/platforms/83xx/mpc834x_mds.c    |    5 +----
> > > arch/powerpc/platforms/83xx/mpc836x_mds.c    |    5 +----
> > > arch/powerpc/platforms/83xx/mpc837x_mds.c    |    5 +----
> > > arch/powerpc/platforms/85xx/mpc85xx_ads.c    |    5 +----
> > > arch/powerpc/platforms/85xx/mpc85xx_cds.c    |    6 +-----
> > > arch/powerpc/platforms/85xx/mpc85xx_mds.c    |    5 +----
> > > arch/powerpc/platforms/embedded6xx/ls_uart.c |    5 +----
> >
> > I believe I got the 83xx and 85xx already.   look at my tree.
>
> Okay, I can drop those and repost.

Actually, that's too much work... I'll wait until paulus pulls your
tree, rebase and then repost.

/me is lazy.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
