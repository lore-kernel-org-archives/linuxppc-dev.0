Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 42469DDDEC
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 02:37:56 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mAKFbeE8005108
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 10:37:40 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mAKFbp7U177774
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 10:37:51 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mAKFbVpA006191
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 10:37:31 -0500
Date: Thu, 20 Nov 2008 10:37:33 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: times(2) sys call bug?
Message-ID: <20081120103733.6f347180@zod.rchland.ibm.com>
In-Reply-To: <1227193640.5224.90.camel@gentoo-jocke.transmode.se>
References: <1227193640.5224.90.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 20 Nov 2008 16:09:16 +0100
"Joakim Tjernlund" <joakim.tjernlund@transmode.se> wrote:

> Why does the below program end up reporting -1
> multiple seconds when times() wrap:

http://sources.redhat.com/bugzilla/show_bug.cgi?id=5209

josh
