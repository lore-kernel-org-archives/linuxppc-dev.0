Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D3F71DEB7C
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 03:10:06 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3LH7avH014270
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 13:07:36 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3LHA2Di221116
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 11:10:03 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3LHA28J011913
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 11:10:02 -0600
Date: Mon, 21 Apr 2008 12:05:30 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: RFC: Possible section mismatch problem in ibm_newemac?
Message-ID: <20080421120530.259b2094@zod.rchland.ibm.com>
In-Reply-To: <480CBA91.5050003@harris.com>
References: <480CBA91.5050003@harris.com>
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

On Mon, 21 Apr 2008 12:02:25 -0400
"Steven A. Falco" <sfalco@harris.com> wrote:

> I am using a recent DENX git tree.  I want to enable debugging in prom_parse.c.
> When I do that, I see link warnings like:

I already sent a patch a month and a half ago to clean all these
warnings up.  It never got pushed upstream.

josh
