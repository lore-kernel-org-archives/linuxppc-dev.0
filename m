Return-Path: <CFRIESEN@nortel.com>
Received: from zrtps0kp.nortel.com (zrtps0kp.nortel.com [47.140.192.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 1B06FB70D6
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2010 08:45:18 +1000 (EST)
Message-ID: <4C92998C.7000903@nortel.com>
Date: Thu, 16 Sep 2010 16:26:20 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: linux support for freescale e5500 core?
References: <4C9278CD.10607@genband.com>	<20100916163911.6255d359@schlenkerla.am.freescale.net>	<4C928FC5.9050700@genband.com>
	<1284674628.30449.98.camel@pasglop>
In-Reply-To: <1284674628.30449.98.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Chris Friesen <chris.friesen@genband.com>,
	Scott Wood <scottwood@freescale.com>, paulus@samba.org,
	timur@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/16/2010 04:03 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2010-09-16 at 15:44 -0600, Chris Friesen wrote:

>> Right.  We currently use a 970-series cpu and have implemented a
>> per-process flag to indicate whether 32-byte mode is needed or not.
>> We'd have to do something similar with the new cpu.
> 
> Sounds like a candidate for upstreaming the patch :-)

As I recall we proposed upstreaming it a while back but there wasn't a
lot of interest since it's most useful in supporting poorly-written
legacy apps. :)

Chris



-- 
The author works for GENBAND Corporation (GENBAND) who is solely
responsible for this email and its contents. All enquiries regarding
this email should be addressed to GENBAND. Nortel has provided the use
of the nortel.com domain to GENBAND in connection with this email solely
for the purpose of connectivity and Nortel Networks Inc. has no
liability for the email or its contents. GENBAND's web site is
http://www.genband.com
