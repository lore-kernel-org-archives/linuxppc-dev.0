Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E0E1567EC4
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 11:52:54 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAB0qo1b002896
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 19:52:50 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAB0qo2d296588
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 19:52:50 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAB0qoYi004415
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 19:52:50 -0500
Date: Fri, 10 Nov 2006 18:52:49 -0600
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH]: PowerPC: make sure the rtas stop-self token is defined.
Message-ID: <20061111005248.GW30625@austin.ibm.com>
References: <20061110182253.GV30625@austin.ibm.com>
	<17749.4445.46239.450000@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17749.4445.46239.450000@cargo.ozlabs.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Nov 11, 2006 at 10:55:09AM +1100, Paul Mackerras wrote:
> Linas Vepstas writes:
> 
> > I presume this looks reasonable, please apply.
> 
> OK, is this a fix for a bug that needs to be fixed before 2.6.19 is
> release?

Probably not. This was uncovered during "unusual" testing, with user
catting values int sysfs files.  Since you need to be root to do this,
I don't think its a security flaw.

--linas
