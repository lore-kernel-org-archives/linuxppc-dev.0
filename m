Return-Path: <linas@austin.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3B74A67A71
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2005 07:07:23 +1100 (EST)
Received: from e31.co.us.ibm.com (e31.esmtp.ibm.com [9.14.4.129])
	by pokfb.esmtp.ibm.com (8.12.11/8.12.11) with ESMTP id j29K1fZc004880
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Mar 2005 15:01:42 -0500
Date: Wed, 9 Mar 2005 14:01:09 -0600
To: Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <20050309200109.GG1220@austin.ibm.com>
References: <20050309120343.0c22eb0f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050309120343.0c22eb0f.sfr@canb.auug.org.au>
From: Linas Vepstas <linas@austin.ibm.com>
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [RFC][PATCH] combining header files
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 09, 2005 at 12:03:43PM +1100, Stephen Rothwell was heard to remark:
> Hi all,
> 
> I would just like to start a discussion about consolidating (some of) the
> ppc and ppc64 header files.  As a starting point (am I am not saying that
> this is the right way to go) the following patch replaces (semantically)
> equivalent ppc64 headers files by just including the asm-ppc file.

Why not #include <asm-generic/whatever.h> instead? 

> We *could* use this method to make the journey incremental until there
> are no nontrivial files left in asm-ppc64 ....

sounds good to me.

--linas
