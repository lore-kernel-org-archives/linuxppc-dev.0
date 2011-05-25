Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D0F1EB6F9B
	for <linuxppc-dev@ozlabs.org>; Wed, 25 May 2011 20:44:46 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p4PAbTI9007886
	for <linuxppc-dev@ozlabs.org>; Wed, 25 May 2011 04:37:29 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	p4PAie4x158722
	for <linuxppc-dev@ozlabs.org>; Wed, 25 May 2011 04:44:40 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p4PAidfI001099
	for <linuxppc-dev@ozlabs.org>; Wed, 25 May 2011 04:44:39 -0600
Date: Wed, 25 May 2011 06:45:49 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: efti <eftakhar.chowdhury@yahoo.com>
Subject: Re: Cannot run  tcl program of PPC460EX
Message-ID: <20110525104549.GC22207@zod.rchland.ibm.com>
References: <31696288.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <31696288.post@talk.nabble.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 24, 2011 at 11:16:12PM -0700, efti wrote:
>
>Hi,
>
>I am trying to run tcl of my PPC460ex board. I have download the
>tcl-8.3.3-sol26-sparc-local.gz file. But when I run it I get the Syntax
>error.

That tarball seems to indicate it's for both Solaris and Sparc.
PPC460ex is neither of those.

>I am not sure if I missed out something.
>
>I would really appreciate it if somebody could help me on this.

We'd need more information.  Things like:

1) What kernel you are running
2) What userspace OS
3) The URL to the tcl you're downloading
4) The actual error message

josh
