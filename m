Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 74F09DDF13
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Aug 2007 07:51:08 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7OLp5bE022117
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 17:51:05 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7OLp4Om218360
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 15:51:04 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7OLp491023209
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 15:51:04 -0600
Date: Fri, 24 Aug 2007 16:51:03 -0500
To: David Miller <davem@davemloft.net>
Subject: Re: RFC: issues concerning the next NAPI interface
Message-ID: <20070824215103.GO4282@austin.ibm.com>
References: <20070824085203.42f4305c@freepuppy.rosehill.hemminger.net>
	<OF0002C3DB.2E4C4A38-ON88257341.005B1253-88257341.005C7C2A@us.ibm.com>
	<20070824.144436.59664160.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070824.144436.59664160.davem@davemloft.net>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: tklein@de.ibm.com, netdev-owner@vger.kernel.org, themann@de.ibm.com,
	netdev@vger.kernel.org, shemminger@linux-foundation.org,
	dlstevens@us.ibm.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, raisch@de.ibm.com, meder@de.ibm.com,
	akepner@sgi.com, ossthema@de.ibm.com, stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 24, 2007 at 02:44:36PM -0700, David Miller wrote:
> From: David Stevens <dlstevens@us.ibm.com>
> Date: Fri, 24 Aug 2007 09:50:58 -0700
> 
> >         Problem is if it increases rapidly, you may drop packets
> > before you notice that the ring is full in the current estimated
> > interval.
> 
> This is one of many reasons why hardware interrupt mitigation
> is really needed for this.

When turning off interrupts, don't turn them *all* off.
Leave the queue-full interrupt always on.

--linas
