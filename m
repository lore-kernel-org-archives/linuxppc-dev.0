Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CB083B6EF6
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 11:25:13 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nAI0MqWq015486
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 17:22:52 -0700
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	nAI0P6oe249886
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 17:25:06 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nAI0Qk3r018202
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 17:26:47 -0700
Date: Tue, 17 Nov 2009 19:25:02 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: pbathija@amcc.com
Subject: Re: [PATCH] [PPC4xx] Fix device tree dts file for katmai board.
Message-ID: <20091118002502.GO30489@zod.rchland.ibm.com>
References: <1258503588-7844-1-git-send-email-pbathija@amcc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1258503588-7844-1-git-send-email-pbathija@amcc.com>
Cc: linuxppc-dev@ozlabs.org, sr@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 17, 2009 at 04:19:48PM -0800, pbathija@amcc.com wrote:
>From: Pravin Bathija <pbathija@amcc.com>
>
>   Set size cell value to 2 for 4GB memory support in katmai. Also set PCI-E
>   node inbound DMA ranges size to 4GB for correct boot up of katmai.
>Content-Type: text/plain; charset=utf-8
>
>Signed-off-by: Pravin Bathija <pbathija@amcc.com>
>Acked-by: Feng Kan <fkan@amcc.com>
>Acked-by: Prodyut Hazarika <phazarika@amcc.com>
>Acked-by: Loc Ho <lho@amcc.com>
>Acked-by: Tirumala Reddy Marri <tmarri@amcc.com>
>Acked-by: Victor Gallardo <vgallardo@amcc.com>

This conflicts with one I already have queued up in my next branch.  It also
seems to lack some of the changes that patch has.

Stefan, can you look this over and work out with Pravin what to do?

josh
