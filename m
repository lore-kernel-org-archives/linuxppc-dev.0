Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C358167A2E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Apr 2005 23:55:54 +1000 (EST)
In-Reply-To: <200504141534.10883.Schramel.Linux@go.bartec.de>
References: <1628E43D99629C46988BE46087A3FBB9205B50@ep-01.EmbeddedPlanet.local>
	<200504141534.10883.Schramel.Linux@go.bartec.de>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <69d6c72eb39adf58f9138ec9e53a3c40@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 14 Apr 2005 09:55:44 -0400
To: Marco Schramel <Schramel.Linux@go.bartec.de>
Cc: Steven Blakeslee <BlakesleeS@embeddedplanet.com>,
	PPC_LINUX <linuxppc-embedded@ozlabs.org>
Subject: Re: CPM uart
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Apr 14, 2005, at 9:34 AM, Marco Schramel wrote:

>> The selection of the BRGs is hard coded last time I checked.

Newer drivers don't do this.  They are probably stuck in the 
linuxppc_devel
kernels and never made it into the main tree.  The only problem with
BRGs will be with 8xx, where the max is 4 and some variants have fewer.


	-- Dan
