Return-Path: <cfriesen@nortelnetworks.com>
Received: from zcars04e.nortelnetworks.com (zcars04e.nortelnetworks.com
	[47.129.242.56]) by ozlabs.org (Postfix) with ESMTP id DB57A2BDB4
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Oct 2004 08:02:53 +1000 (EST)
Message-ID: <41670E86.10504@nortelnetworks.com>
Date: Fri, 08 Oct 2004 16:02:46 -0600
From: Chris Friesen <cfriesen@nortelnetworks.com>
MIME-Version: 1.0
To: Arrigo Benedetti <arrigo@bologna.vision.caltech.edu>
References: <416709B8.8080107@vision.caltech.edu>
In-Reply-To: <416709B8.8080107@vision.caltech.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Update frequency of Time Base reg?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arrigo Benedetti wrote:
> Dear all,
> 
> I'm looking for information about the update frequency of the Time Base 
> register
> for the latest dual G5 Powermac and Xserve models.
> By the way, what is the best way to find this kind of information?

33.3 MHz, I think.

The most portable way to find it is to calibrate it against gettimeofday().  For 
our product kernels, I've exported it via /proc.

Chris
