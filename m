Return-Path: <linas@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3DF5DDDD07
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 02:23:54 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l48GNpuN001785
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 12:23:51 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l48GNpW0177538
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 10:23:51 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l48GNoKV007100
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 10:23:51 -0600
Date: Tue, 8 May 2007 11:23:50 -0500
To: Srinivasa Ds <srinivasa@in.ibm.com>
Subject: Re: kernel expection generated with 2.6.21-mm1 kernel boot up
Message-ID: <20070508162350.GM4452@austin.ibm.com>
References: <463F06E2.5060308@linux.vnet.ibm.com>
	<1178538912.24522.12.camel@concordia.ozlabs.ibm.com>
	<463F1CA9.40501@linux.vnet.ibm.com> <4640675C.6090104@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4640675C.6090104@in.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Balbir Singh <balbir@linux.vnet.ibm.com>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 08, 2007 at 05:34:44PM +0530, Srinivasa Ds wrote:
> 
> Looks like problem is in SLUB layer, I unmarked SLUB(CONFIG_SLUB)
> option and now system is booting.

Its been repored by others (and I can reproduce it),
its a problem with a bad interaction with SLUB and pg_tables
A patch flew by recetnly that would not use slub for pg_tables, 
but I don't know if that's the permanent fix.

--linas
