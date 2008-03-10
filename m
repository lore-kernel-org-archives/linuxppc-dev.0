Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A7153DE035
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Mar 2008 07:34:32 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JYohY-0004zc-Dc
	for linuxppc-embedded@ozlabs.org; Mon, 10 Mar 2008 13:34:28 -0700
Message-ID: <15954121.post@talk.nabble.com>
Date: Mon, 10 Mar 2008 13:34:28 -0700 (PDT)
From: khollan <khollan@daktronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: RE: Xilinx Temac link detect
In-Reply-To: <EDAE140DF1B2FC42B5867C22CA0B333FA3CF03@XMBIL132.northgrum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <15616042.post@talk.nabble.com> <15883376.post@talk.nabble.com>
	<20080306221446.4509A1118051@mail123-sin.bigfish.com>
	<EDAE140DF1B2FC42B5867C22CA0B333FA3CF03@XMBIL132.northgrum.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Koss, Mike (Mission Systems) wrote:
> 
> Here's a snippet from a program I use to debug an ethernet driver that I
> have using ioctl's. The ethernet ioctl interface is slightly different
> from a "normal" ioctl in that it uses sockets and not a file descriptor.
> The ioctl's I use are added to the ioctl interface in the driver, using
> the defined device-specific range (that was supposed to disappear in
> 2.5.x or 2.6.x). With this I read/write my phy register's to test out
> the interface between my TEMAC and my PHY. 
> 
> 
Thanks for the example, everything working great now.

Kevin
-- 
View this message in context: http://www.nabble.com/Xilinx-Temac-link-detect-tp15616042p15954121.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
