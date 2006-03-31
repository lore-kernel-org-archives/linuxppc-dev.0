Return-Path: <rick.jones2@hp.com>
Received: from palrel10.hp.com (palrel10.hp.com [156.153.255.245])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "palrel10.hp.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id B0C4B679F9
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Apr 2006 04:53:50 +1100 (EST)
Message-ID: <442D689E.9080209@hp.com>
Date: Fri, 31 Mar 2006 09:36:30 -0800
From: Rick Jones <rick.jones2@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH]: e1000: prevent statistics from getting garbled during
	reset.
References: <20060330213928.GQ2172@austin.ibm.com>	<20060331000208.GS2172@austin.ibm.com>	<442C8069.507@wolfmountaingroup.com>	<20060331003506.GU2172@austin.ibm.com>	<442CACC0.1060308@wolfmountaingroup.com>
	<20060331170319.GV2172@austin.ibm.com>
In-Reply-To: <20060331170319.GV2172@austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: netdev@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 2) What's wrong with taking deltas? Typical through-put performance
> measurement is done by pre-loading the pipes (i.e. running for
> a few minutes wihtout measuring, then starting the measurement).
> I'd think that snapshotting the numbers would be easier, and is 
> trivially doable in user-space. I guess I don't understand why 
> you need a new kernel featre to imlement this.

ftp://ftp.cup.hp.com/dist/networking/tools/beforeafter.tar.gz

Not my code, I've used it with success against ethtool -S output.

rick jones
