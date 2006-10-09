Return-Path: <jdub@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 461B0679E0
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Oct 2006 22:45:28 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k99CjNw0017203
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Oct 2006 08:45:23 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k99CjNDY338058
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Oct 2006 06:45:23 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k99CjNWg008682
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Oct 2006 06:45:23 -0600
Subject: Re: [PATCH] ARCH=ppc pt_regs fixes
From: Josh Boyer <jdub@us.ibm.com>
To: Al Viro <viro@ftp.linux.org.uk>
In-Reply-To: <20061009114842.GO29920@ftp.linux.org.uk>
References: <20061009114842.GO29920@ftp.linux.org.uk>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 07:49:06 -0500
Message-Id: <1160398146.5626.1.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-10-09 at 12:48 +0100, Al Viro wrote:
>  arch/ppc/syslib/ppc4xx_pic.c        |    8 ++++----

I already sent a patch for this file and I was working on some of the
other 4xx stuff.  But overall yours is much more comprehensive.

Ack-by: Josh Boyer <jdub@us.ibm.com>

josh
