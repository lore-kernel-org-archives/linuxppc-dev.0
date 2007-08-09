Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8B432DDD08
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 16:31:22 +1000 (EST)
Message-ID: <46BAB4AF.7010001@garzik.org>
Date: Thu, 09 Aug 2007 02:31:11 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 0/1] lro: Generic Large Receive Offload for TCP traffic
References: <200708031441.14780.ossthema@de.ibm.com>
	<20070808.231144.22645124.davem@davemloft.net>
In-Reply-To: <20070808.231144.22645124.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: tklein@de.ibm.com, themann@de.ibm.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, raisch@de.ibm.com,
	linuxppc-dev@ozlabs.org, ossthema@de.ibm.com, meder@de.ibm.com,
	gallatin@myri.com, stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Miller wrote:
> From: Jan-Bernd Themann <ossthema@de.ibm.com>
> Date: Fri, 3 Aug 2007 14:41:14 +0200
> 
>> I think this patch could be the final version for now. It has been tested
>> on two platforms (power and x86_64) and works very well.
> 
> I checked in the LRO patch and the two sample driver ports
> to net-2.6.24, thanks!

Good to hear, thanks all.

I'll ponder whether I want to rebase netdev-2.6.git#upstream (2.6.24 
queue) on top of net-2.6.24.  I might put it off until the pain 
threshold rises, or I might go ahead and do it.  Undecided.

Either way, I'll want you to push to Linus before I do, when the next 
merge window opens.

	Jeff
