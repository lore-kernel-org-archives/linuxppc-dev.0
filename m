Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 70AF2B7B66
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Dec 2009 11:53:10 +1100 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nB80ld2v011164
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Dec 2009 17:47:39 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nB80r1WF168400
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Dec 2009 17:53:01 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nB80r0RR019634
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Dec 2009 17:53:00 -0700
Date: Mon, 7 Dec 2009 19:52:57 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Tirumala Reddy Marri <tmarri@amcc.com>
Subject: Re: patch status
Message-ID: <20091208005257.GL2937@zod.rchland.ibm.com>
References: <AC5E1C3367E37D44970B81A6ADD1DA2C0872CE8B@SDCEXCHANGE01.ad.amcc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AC5E1C3367E37D44970B81A6ADD1DA2C0872CE8B@SDCEXCHANGE01.ad.amcc.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 07, 2009 at 02:01:58PM -0800, Tirumala Reddy Marri wrote:
>Hi Ben,
>
> Did you get the chance to review the patch I sent it on Dec-1 2009
>
> 
>
>http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-December/078436.html

Ben has to review lots of patches.  Please be patient.  Also, your patch is
tracked via patchwork here:

http://patchwork.ozlabs.org/patch/39865/

so you can see the state as it progresses.

Further, it would have been helpful to CC the maintainer of the 4xx sub-arch
(me) since it impacts that platform and you could have gotten some review more
quickly.  I didn't notice it until this afternoon.

Lastly, your patch has lots of magical values in it.  While I have no doubt
they are correct, I can't find any documentation for 460SX on the AMCC website
aside from some small product briefs.  Perhaps I've overlooked the CPU manual,
but since I don't have such a board or the manual for it, it would be nice to
know what kind of testing has been done with this patch.  A simple statement
such as "tested on kernel <version> with a <network, raid, whatever> pci-e
card successfully" would go a long way.

This is not a rant or complaint about the code.  Just a reminder that the
community doesn't always move at the pace we would all like :).  I'll try and
look over the patch more carefully tomorrow.

josh
