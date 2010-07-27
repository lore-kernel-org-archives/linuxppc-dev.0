Return-Path: <dave@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 820D1B70B5
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jul 2010 12:36:59 +1000 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e7.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6R2O1oZ011509
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 22:24:01 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6R2at7R1269896
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 22:36:55 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6R2as4Y013907
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 22:36:55 -0400
Subject: Re: [PATCH 4/8] v3 Allow memory_block to span multiple memory sections
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
In-Reply-To: <4C4A5985.6000206@austin.ibm.com>
References: <4C451BF5.50304@austin.ibm.com>
	<4C451E1C.8070907@austin.ibm.com> <1279653481.9785.4.camel@nimitz>
	<4C4A5985.6000206@austin.ibm.com>
Content-Type: text/plain; charset="ANSI_X3.4-1968"
Date: Mon, 26 Jul 2010 19:36:52 -0700
Message-ID: <1280198212.16922.422.camel@nimitz>
Mime-Version: 1.0
Cc: linux-mm@kvack.org, greg@kroah.com, linux-kernel@vger.kernel.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-07-23 at 22:09 -0500, Nathan Fontenot wrote:
> If we add a lock should I submit it as part of this patchset? or
> submit it
> as a follow-on?

It should probably be at the beginning of the patch set.  We don't want
to have a case where your set introduces races that we _need_ a later
patch to fix.

-- Dave
