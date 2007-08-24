Return-Path: <rick.jones2@hp.com>
Received: from palrel10.hp.com (palrel10.hp.com [156.153.255.245])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "palrel10.hp.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 81516DDE49
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Aug 2007 03:21:09 +1000 (EST)
Message-ID: <46CF1069.7090406@hp.com>
Date: Fri, 24 Aug 2007 10:07:53 -0700
From: Rick Jones <rick.jones2@hp.com>
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: RFC: issues concerning the next NAPI interface
References: <200708241559.17055.ossthema@de.ibm.com>	<20070824153703.GN5592@sgi.com>	<200708241747.16592.ossthema@de.ibm.com>	<20070824085203.42f4305c@freepuppy.rosehill.hemminger.net>
	<20070824165110.GH4282@austin.ibm.com>
In-Reply-To: <20070824165110.GH4282@austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Jan-Bernd Themann <ossthema@de.ibm.com>, Eder <meder@de.ibm.com>,
	akepner@sgi.com, Stephen Hemminger <shemminger@linux-foundation.org>,
	Marcus@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Just to be clear, in the previous email I posted on this thread, I
> described a worst-case network ping-pong test case (send a packet, wait
> for reply), and found out that a deffered interrupt scheme just damaged
> the performance of the test case.  Since the folks who came up with the
> test case were adamant, I turned off the defferred interrupts.  
> While defferred interrupts are an "obvious" solution, I decided that 
> they weren't a good solution. (And I have no other solution to offer).

Sounds exactly like the default netperf TCP_RR test and any number of other 
benchmarks.  The "send  a request, wait for reply, send next request, etc etc 
etc" is a rather common application behaviour afterall.

rick jones
