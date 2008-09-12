Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B4853DE001
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Sep 2008 10:47:29 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m8C0lO8F016817
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 20:47:24 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m8C0lO2C167560
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 18:47:24 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m8C0lNen020271
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 18:47:23 -0600
Date: Thu, 11 Sep 2008 20:47:16 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH] powerpc: add support for PAGE_SIZEs greater than 4KB for
Message-ID: <20080911204716.7b5d236d@zod.rchland.ibm.com>
In-Reply-To: <48C9ABFF.1080507@emcraft.com>
References: <1221083587-8091-1-git-send-email-yanok@emcraft.com>
	<1221083587-8091-2-git-send-email-yanok@emcraft.com>
	<49c0ff980809110957h4b7b85d4ie39dbb27d1edbe39@mail.gmail.com>
	<1715327082.20080911221507@emcraft.com>
	<20080911200906.GD26684@yoda.jdub.homelinux.org>
	<48C9ABFF.1080507@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, prodyut hazarika <prodyuth@gmail.com>, dzu@denx.de,
	wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 12 Sep 2008 03:38:39 +0400
Ilya Yanok <yanok@emcraft.com> wrote:

> Hello Josh,
> 
> Josh Boyer wrote:
> > Ok, but not everyone does.  And I think setting the page size to this
> > should be harder, maybe even dependent upon CONFIG_BROKEN.
> >   
> 
> Well, we are violating ELF standard here... CONFIG_BROKEN seems to be 
> adequate for me.

Right, that was my thinking as well.  You can add an explanation for
that in the help text.

josh
