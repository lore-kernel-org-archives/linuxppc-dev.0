Return-Path: <greg@kroah.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com",
	Issuer "Network Services" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A11722BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Jan 2005 06:23:35 +1100 (EST)
Received: from e31.co.us.ibm.com (e31.esmtp.ibm.com [9.14.4.129])
	by pokfb.esmtp.ibm.com (8.12.10/8.12.10) with ESMTP id j0EIgEjK022348
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=OK)
	for <linuxppc-embedded@ozlabs.org>; Fri, 14 Jan 2005 13:42:15 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e31.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j0EIg9m4327156
	for <linuxppc-embedded@ozlabs.org>; Fri, 14 Jan 2005 13:42:09 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j0EIg9jw448146
	for <linuxppc-embedded@ozlabs.org>; Fri, 14 Jan 2005 11:42:09 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id
	j0EIg9tK003751
	for <linuxppc-embedded@ozlabs.org>; Fri, 14 Jan 2005 11:42:09 -0700
Date: Fri, 14 Jan 2005 10:41:46 -0800
From: Greg KH <greg@kroah.com>
To: Kumar Gala <galak@somerset.sps.mot.com>
Message-ID: <20050114184146.GA30093@kroah.com>
References: <Pine.LNX.4.61.0501131816260.27470@blarg.somerset.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.61.0501131816260.27470@blarg.somerset.sps.mot.com>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com,
	linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] I2C-MPC: use wait_event_interruptible_timeout between
	transactions
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Jan 13, 2005 at 06:21:54PM -0600, Kumar Gala wrote:
> Use wait_event_interruptible_timeout so we dont waste time waiting between 
> transactions like we use to.  Also, we use the adapters timeout so the 
> ioctl cmd I2C_TIMEOUT will now work.

Applied, thanks.

greg k-h
