Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 49096DDE09
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 07:12:17 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8QLC3hh027160
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 17:12:03 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8QLC2T1172830
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 15:12:03 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8QLC2Jo006721
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 15:12:02 -0600
Date: Wed, 26 Sep 2007 16:12:01 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 0/3] PowerPC: Add cpu_setup functionality to 44x platform
Message-ID: <20070926161201.348c1176@weaponx.rchland.ibm.com>
In-Reply-To: <20070921144149.GA4150@ru.mvista.com>
References: <20070921144149.GA4150@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 21 Sep 2007 18:41:49 +0400
Valentine Barshak <vbarshak@ru.mvista.com> wrote:

> This patchset adds cpu_setup functionality to PowerPC 44x,
> moves FPU init to cpu_setup callback and adds 440EPx/440GRx
> incorrect write to DDR SDRAM errata workaround.

This set looks pretty good to me.  Aside from the slight oddity of
adding an essentially empty file in the first patch.  But it makes
things nicely bisectable and I asked for it to be done that way.

Unless someone has objections, I'll probably pull this in soon after I
test a bit.

josh
