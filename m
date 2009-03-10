Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id A7AEADE0A2
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 04:36:24 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so987979yxb.39
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 10:36:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090310.101959.142777275.davem@davemloft.net>
References: <20090218.134852.118040610.davem@davemloft.net>
	<ae4f76fd0902190145r7ed5fadbwfca18c97dbfc9ed1@mail.gmail.com>
	<fa686aa40903101013j2324e8acw18830c930e12ae46@mail.gmail.com>
	<20090310.101959.142777275.davem@davemloft.net>
Date: Tue, 10 Mar 2009 11:36:22 -0600
Message-ID: <fa686aa40903101036v430d968cs436902698be53c95@mail.gmail.com>
Subject: Re: net_device_ops support in bridging and fec_mpc52xx.c
From: Grant Likely <grant.likely@secretlab.ca>
To: David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, henk.stegeman@gmail.com,
	bridge@osdl.org, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 10, 2009 at 11:19 AM, David Miller <davem@davemloft.net> wrote:
> Send it to netdev, CC:'d to me, Jeff hasn't been handling networking
> driver changes for a while now.

Ah, okay.  I didn't know.  I looked in MAINTAINERS today, and Jeff is
listed there for NETWORK DEVICE DRIVERS.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
