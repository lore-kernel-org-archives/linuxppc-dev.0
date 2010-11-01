Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 53D43B6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Nov 2010 00:18:24 +1100 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id oA1DDkpQ023908
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Nov 2010 07:13:46 -0600
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oA1DI0XG181070
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Nov 2010 07:18:02 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oA1DLwO3025716
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Nov 2010 07:21:58 -0600
Date: Mon, 1 Nov 2010 09:17:04 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Oliver Kowalke <oliver.kowalke@gmx.de>
Subject: Re: eabi supported
Message-ID: <20101101131704.GA5343@zod.rchland.ibm.com>
References: <4CCDBB78.7000600@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CCDBB78.7000600@gmx.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Oct 31, 2010 at 07:54:48PM +0100, Oliver Kowalke wrote:
>Hi,
>
>could you tell me which Linux distribution does support powerpc with
>eabi (embedded abi)?
>
>I tried 'T2 Project' but it doesn't offer ABI selection in its config
>script.

eabi isn't really used all that much on powerpc.  I don't know of a
community distro that supports powerpc in general, much less with eabi.
You might be able to get it from one of the embedded linux vendors, but
you'd have to contact them.

josh
