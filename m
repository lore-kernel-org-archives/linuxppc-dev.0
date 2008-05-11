Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 53032DDDFF
	for <linuxppc-dev@ozlabs.org>; Mon, 12 May 2008 07:15:50 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4BLCc1X012659
	for <linuxppc-dev@ozlabs.org>; Sun, 11 May 2008 17:12:38 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4BLFmwZ104254
	for <linuxppc-dev@ozlabs.org>; Sun, 11 May 2008 15:15:48 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4BLFlYS014404
	for <linuxppc-dev@ozlabs.org>; Sun, 11 May 2008 15:15:48 -0600
Date: Sun, 11 May 2008 16:13:26 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: Re: Fix arch/ppc builds
Message-ID: <20080511161326.25270b01@zod.rchland.ibm.com>
In-Reply-To: <1210114730-5047-1-git-send-email-segher@kernel.crashing.org>
References: <1210114730-5047-1-git-send-email-segher@kernel.crashing.org>
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

On Wed,  7 May 2008 00:58:47 +0200
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> 
> These three trivial patches make arch/ppc build again.

We should either take these for 2.6.26, or drop arch/ppc altogether.
Leaving it in-tree but broken just seems like bad form :).

josh
