Return-Path: <xma@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C51EADDEEB
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Aug 2007 03:45:44 +1000 (EST)
In-Reply-To: <20070824165110.GH4282@austin.ibm.com>
To: linas@austin.ibm.com (Linas Vepstas)
MIME-Version: 1.0
Subject: Re: RFC: issues concerning the next NAPI interface
Message-ID: <OFB48299BB.9D9BCE91-ON87257341.006139E9-88257341.00614EB7@us.ibm.com>
From: Shirley Ma <xma@us.ibm.com>
Date: Fri, 24 Aug 2007 10:45:17 -0700
Content-Type: text/plain; charset="US-ASCII"
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, netdev-owner@vger.kernel.org,
	linux-ppc <linuxppc-dev@ozlabs.org>, akepner@sgi.com,
	Eder <meder@de.ibm.com>, Jan-Bernd Themann <ossthema@de.ibm.com>,
	Stephen Hemminger <shemminger@linux-foundation.org>, Marcus@ozlabs.org
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
> the performance of the test case. 

When splitting rx and tx handler, I found some performance gain by 
deffering interrupt scheme in tx not rx in IPoIB driver.

Shirley
