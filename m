Return-Path: <ostampflee@terrasoftsolutions.com>
Received: from newhope.terraplex.com (newhope1.terraplex.com [66.7.161.2])
	by ozlabs.org (Postfix) with ESMTP id 13AE26808C
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Aug 2005 05:31:15 +1000 (EST)
Received: from [192.168.0.105] (S010600095bdadbc7.gv.shawcable.net
	[24.68.241.79])
	by newhope.terraplex.com (Postfix) with ESMTP id 7EA6F358015
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2005 13:31:09 -0600 (MDT)
From: Owen Stampflee <ostampflee@terrasoftsolutions.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1123689464.3664.10.camel@beast.terraplex.com>
References: <1123689464.3664.10.camel@beast.terraplex.com>
Content-Type: text/plain
Message-Id: <1123702002.5579.1.camel@beast.terraplex.com>
Mime-Version: 1.0
Date: Wed, 10 Aug 2005 12:26:42 -0700
Subject: Re: PowerBook5,4 sleep w/2.6.12
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Turns out that somehow CPUFREQ was forgotten in the config,enabling it
fixed the problem.

Thanks for the input guys.
