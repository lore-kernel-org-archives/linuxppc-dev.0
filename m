Return-Path: <ak@suse.de>
Received: from mx2.suse.de (ns2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 62C37DDF81
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Mar 2007 13:06:36 +1100 (EST)
Sender: ak@suse.de
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: [PATCH] ehea: Optional TX/RX path optimized for SMP
References: <200702231730.58579.ossthema@de.ibm.com>
From: Andi Kleen <andi@firstfloor.org>
Date: 03 Mar 2007 04:06:08 +0100
In-Reply-To: <200702231730.58579.ossthema@de.ibm.com>
Message-ID: <p73mz2vauvz.fsf@bingen.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jan-Bernd Themann <ossthema@de.ibm.com> writes:
> 
> Are there any concerns about this approach?

Yes. You should fix the NAPI code instead of trying to work
around it.

-Andi
