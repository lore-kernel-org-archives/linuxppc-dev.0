Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp06.au.ibm.com (ausmtp06.au.ibm.com [202.81.18.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DC17EDDFA6
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 10:47:20 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.18.232])
	by ausmtp06.au.ibm.com (8.13.8/8.13.8) with ESMTP id l6N0lm1E3227898
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 10:47:50 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6N0kScd038842
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 10:46:28 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6N0l26l007074
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 10:47:02 +1000
Date: Wed, 18 Jul 2007 13:26:32 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [patch 02/14] Rename 4xx paths to 40x
Message-ID: <20070718032632.GE18251@localhost.localdomain>
References: <20070717181547.310201000@linux.vnet.ibm.com>>
	<20070717182620.683036000@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070717182620.683036000@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 17, 2007 at 01:15:49PM -0500, Josh Boyer wrote:
> 4xx is a bit of a misnomer for certain things, as they really apply to PowerPC
> 40x only.  Rename some of the files to clean this up.
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Looks good

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
