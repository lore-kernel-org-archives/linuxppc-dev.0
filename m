Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0D933DDE11
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 07:59:34 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6QLxTK6030388
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 17:59:29 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6QLxTRh470744
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 17:59:29 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6QLxT3t021743
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 17:59:29 -0400
Date: Thu, 26 Jul 2007 16:59:28 -0500
To: Siva Prasad <sprasad@bivio.net>
Subject: Re: dlopen source
Message-ID: <20070726215928.GG9876@austin.ibm.com>
References: <D83235F0F3C86D4D889D8B9A0DA8C6D78D86C2@corpexc01.corp.networkrobots.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D83235F0F3C86D4D889D8B9A0DA8C6D78D86C2@corpexc01.corp.networkrobots.com>
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

On Thu, Jul 26, 2007 at 12:47:57PM -0700, Siva Prasad wrote:
> Hi,
> 
> Can some one point to where I can find the source code for dlopen()
> function.

? Should be in glibc, right? I don't remember f it requires binutils
pieces or not.

(Yes, glibc is a rats nest, so understanding how it works is a whole
nuther thing.)

--linas
