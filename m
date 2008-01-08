Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E316CDE006
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 03:09:44 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m08G9eZG005159
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 11:09:40 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m08G9eCU166560
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 09:09:40 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m08G9EeU016031
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 09:09:14 -0700
Date: Tue, 8 Jan 2008 10:09:37 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [PATCH] enable built-in networking for Sequoia defconfig
Message-ID: <20080108100937.0cfca4cf@zod.rchland.ibm.com>
In-Reply-To: <1199489214.9673.18.camel@basalt>
References: <1199489214.9673.18.camel@basalt>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 04 Jan 2008 17:26:54 -0600
Hollis Blanchard <hollisb@us.ibm.com> wrote:

> Enable EMAC driver for Sequoia (and while we're in there, disable
> Macintosh drivers for Sequoia and Bamboo).
> 
> Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>

applied, thanks.

josh
