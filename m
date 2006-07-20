Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 36AB967BAD
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Jul 2006 01:41:19 +1000 (EST)
Date: Thu, 20 Jul 2006 19:41:31 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: "Harnois Anne-Sophie" <anne-sophie.harnois@thomson.net>
Subject: Re: multicast for 8260 for 2.6.13
Message-ID: <20060720194131.00b35a61@vitb.ru.mvista.com>
In-Reply-To: <1CFEB358338412458B21FAA0D78FE86D5D2488@rennsmail02.eu.thmulti.com>
References: <1CFEB358338412458B21FAA0D78FE86D5D2488@rennsmail02.eu.thmulti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 20 Jul 2006 16:45:11 +0200
"Harnois Anne-Sophie" <anne-sophie.harnois@thomson.net> wrote:

> Hello
> 
> In the file arch/ppc/8260_io/fcc_enet.c, set_multicast_list function is
> commented out and I can't figure out why. 
> I checked the code, removed the comments and tried it, and multicast
> seemed to work properly. 
> 
> What am I missing?
> Could someone explain me why this is commented out?
The reason is because the arch/ppc/8260_io/* is deprecated by drivers/net/fs_enet, hence
people switched to use it...



-- 
Sincerely, 
Vitaly
