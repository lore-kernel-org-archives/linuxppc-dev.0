Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A48BADE2A4
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 07:18:15 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9UKIB0Z021324
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 16:18:11 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9UKGI3t117454
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 14:18:10 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9UKG922021970
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 14:16:09 -0600
Date: Tue, 30 Oct 2007 15:16:08 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 0/4] PowerPC: 440GRx Rainier board support.
Message-ID: <20071030151608.28a2d706@weaponx.rchland.ibm.com>
In-Reply-To: <20071030164511.GA21973@ru.mvista.com>
References: <20071030164511.GA21973@ru.mvista.com>
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

On Tue, 30 Oct 2007 19:45:11 +0300
Valentine Barshak <vbarshak@ru.mvista.com> wrote:

> The following patches add PowerPC 440GRx Rainier board support.
> The board is almost identical to Sequoia, but doesn't have USB
> and FPU is not supported.

So why do we need anything other than the DTS and the defconfig?  I
would think the sequoia wrapper and platform files would suffice
completely for this.

josh
