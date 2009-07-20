Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1B49EB7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 20 Jul 2009 22:19:07 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n6KCHRxs005932
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2009 06:17:27 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n6KCJ3iB208194
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2009 06:19:03 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6KCJ2YV004738
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2009 06:19:02 -0600
Date: Mon, 20 Jul 2009 08:18:57 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Mohd Arif <mohd.arif@nechclst.in>
Subject: Re: ethtool support in ethernet driver
Message-ID: <20090720121857.GB24196@zod.rchland.ibm.com>
References: <0A8CFEC45B7F4C419F7543867C47442303189F8B@mailserver.nechclst.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0A8CFEC45B7F4C419F7543867C47442303189F8B@mailserver.nechclst.in>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jul 19, 2009 at 05:12:11PM +0530, Mohd Arif wrote:
>Dear All,
>    Happy to be a part of this mailing list!!!!!
>    The issue is that i want to give support of ethtool in ethernet
>driver.

You didn't say whether this is related to PowerPC or not.

>    Where do i need to make changes in the driver?

You didn't say which driver.  There are a lot of them.

>    I have never been into driver stuff.
>    So kindly suggest me accordingly.

If this is just a generic ethernet driver question, you probably want the
netdev mailing list, not this one.

josh
