Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 02F63DE953
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 04:47:10 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7JIl3V4015991
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 14:47:03 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7JIjl5P151798
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 14:45:47 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7JIjkkA018539
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 14:45:47 -0400
Date: Tue, 19 Aug 2008 14:45:45 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 0/9] Rework PowerPC 44x board support
Message-ID: <20080819144545.4cebe670@zod.rchland.ibm.com>
In-Reply-To: <200808192026.12632.sr@denx.de>
References: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
	<200808192026.12632.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 19 Aug 2008 20:26:12 +0200
Stefan Roese <sr@denx.de> wrote:

> On Tuesday 19 August 2008, Josh Boyer wrote:
> > The following patch series reworks the board support code for PowerPC 44x
> > platforms.  It eliminates a number of redundant <board>.c files and add a
> > ppc44x_simple.c file that has an explicit list of boards that are supported
> > by it.  This is the same mechanism that Grant Likely has used for MPC 5200
> > boards.
> >
> > It also adds some more explicit support for Glacier and Yosemite boards, as
> > those boards were using a board level compatible property in their DTS
> > files that was a bit confusing.
> >
> > Review would be appreciated.  Tested on Sequoia, and I plan on testing on
> > as many boards as I can before committing to my tree.
> 
> Looks great at first glance. I'll try to do some testing here too in the next 
> few days.

That would be much appreciated.  I have a number of the effected
boards, but I don't have them all so any testing you can do would be
awesome.

josh
