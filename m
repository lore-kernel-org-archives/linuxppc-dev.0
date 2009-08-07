Return-Path: <tony@bakeyournoodle.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AFA42B7BBC
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 13:49:21 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9BE90DDD01
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2009 13:49:21 +1000 (EST)
Date: Fri, 7 Aug 2009 13:49:21 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.31-rc5-git2 crash [net/core/flow.c:flow_cache_new_hashrnd]
Message-ID: <20090807034921.GA13713@bilbo.ozlabs.org>
References: <4A78292A.5000607@in.ibm.com> <4A783B1F.7000602@in.ibm.com>
	<1249395350.8016.5.camel@concordia>
	<1249597385.24311.10.camel@pasglop>
	<20090807025454.GL3095@hansolo.jdub.homelinux.org>
	<1249614835.24311.11.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1249614835.24311.11.camel@pasglop>
Cc: netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 07, 2009 at 01:13:54PM +1000, Benjamin Herrenschmidt wrote:
 
> I think Tony did yes. Not sure what's the status with the "enterprise"
> distros.

It's fixed in F11 and F12  (thanks to dwmw2), it's in my for-1.3.15 branch for
yaboot. We're working on updateing the version in the enterprise, we'll see
what the next release holds.

Yours Tony
