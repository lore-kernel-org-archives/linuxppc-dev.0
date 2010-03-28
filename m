Return-Path: <julia@diku.dk>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mgw2.diku.dk",
	Issuer "KU Security Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id AB10BB7CB6
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Mar 2010 08:56:52 +1100 (EST)
Date: Sun, 28 Mar 2010 23:56:47 +0200 (CEST)
From: Julia Lawall <julia@diku.dk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: question about drivers/macintosh/windfarm_pm91.c
In-Reply-To: <1269810539.8599.330.camel@pasglop>
Message-ID: <Pine.LNX.4.64.1003282355390.29824@ask.diku.dk>
References: <Pine.LNX.4.64.1003281746570.29824@ask.diku.dk>
	<1269810539.8599.330.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 29 Mar 2010, Benjamin Herrenschmidt wrote:

> On Sun, 2010-03-28 at 17:48 +0200, Julia Lawall wrote:
> > The function wf_smu_remove in the file drivers/macintosh/windfarm_pm91.c 
> > ends with the following code:
> > 
> >         if (wf_smu_slots_fans)
> >                 kfree(wf_smu_cpu_fans);
> > 	if (wf_smu_drive_fans)
> >                 kfree(wf_smu_cpu_fans);
> >         if (wf_smu_cpu_fans)
> >                 kfree(wf_smu_cpu_fans);
> > 
> > This looks quite strange.  Is it supposed to be if (x) kfree(x); in each 
> > case?
> 
> Definitely a typo. In fact, the if () aren't even necessary. Patch
> welcome :-)

I'll send something tomorrow.  I will perhaps keep the ifs, to maintain 
the style of the rest of the function.

julia
