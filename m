Return-Path: <Simon.Richter@hogyros.de>
Received: from kleinhenz.com (static.88-198-202-190.clients.your-server.de
	[88.198.202.190]) by ozlabs.org (Postfix) with ESMTP id 9EC3C67BF2
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 21:24:00 +1000 (EST)
Message-ID: <45127177.3000408@hogyros.de>
Date: Thu, 21 Sep 2006 13:03:19 +0200
From: Simon Richter <Simon.Richter@hogyros.de>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: First cut of "wrapper" program
References: <17681.53490.705075.155580@cargo.ozlabs.ibm.com>
In-Reply-To: <17681.53490.705075.155580@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Paul Mackerras wrote:

> Here is a prototype of a "wrapper" program which will take a kernel,
> and optionally an initrd image and/or a device tree blob, and create a
> bootable zImage.  My idea is that the Makefile in arch/powerpc/boot
> will construct the files that this needs, then run it one or more
> times to create whatever images are needed.

Hmm, in Debian there is a tool called mkvmlinuz that does this, which is
run in a hook script after generating an initrd.

   Simon
