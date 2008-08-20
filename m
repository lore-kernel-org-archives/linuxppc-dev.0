Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 27F01DE02F
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 03:09:17 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7KH9EHW005777
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 13:09:14 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7KH9EHC046384
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 13:09:14 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7KH9DJi014997
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 13:09:13 -0400
Date: Wed, 20 Aug 2008 13:09:13 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "prodyut hazarika" <prodyuth@gmail.com>
Subject: Re: [PATCH 0/9] Rework PowerPC 44x board support
Message-ID: <20080820130913.5e48848e@zod.rchland.ibm.com>
In-Reply-To: <49c0ff980808200954p38e00e7aqb612e7e7eb1bbc51@mail.gmail.com>
References: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
	<200808192026.12632.sr@denx.de>
	<20080819144545.4cebe670@zod.rchland.ibm.com>
	<49c0ff980808200954p38e00e7aqb612e7e7eb1bbc51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 20 Aug 2008 09:54:40 -0700
"prodyut hazarika" <prodyuth@gmail.com> wrote:

> Hi Josh,
> 
> >> >
> >> > Review would be appreciated.  Tested on Sequoia, and I plan on testing on
> >> > as many boards as I can before committing to my tree.
> >>
> 
> The changes looks great.
> >
> > That would be much appreciated.  I have a number of the effected
> > boards, but I don't have them all so any testing you can do would be
> > awesome.
> 
> I tried pulling up the latest code from your git tree. Seems it is not
> yet put in there.

Right.  I tend to not commit patches that even I send out until they've
at least had some review.

> Do I have to manually apply all the patches to my git tree. I was
> planning to test the changes on Canyonlands, glacier and Kilauea
> boards here.

For now, yes.  In a day or so I'll probably fix the small comments I've
gotten and then commit the series to my next branch.

josh
