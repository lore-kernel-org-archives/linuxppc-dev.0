Return-Path: <CFRIESEN@nortel.com>
Received: from zcars04f.nortel.com (zcars04f.nortel.com [47.129.242.57])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id BEF86DDE0E
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Aug 2008 06:39:39 +1000 (EST)
Message-ID: <489222F9.2020806@nortel.com>
Date: Thu, 31 Jul 2008 14:39:21 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Board level compatibility matching
References: <fa686aa40807311319k44d270b0t4fa9cb0e6523339@mail.gmail.com>
In-Reply-To: <fa686aa40807311319k44d270b0t4fa9cb0e6523339@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: devicetree-discuss@ozlabs.org, linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:

> Doing so should simplify adding new board ports.  In many cases it
> would just involve dropping in a new .dts file.  However, it retains
> the flexability of overriding generic code with platform specific
> fixups as the need arises.

If it makes it easier for board vendors to do a clean port, you get a 
vote from me.

I've seen a large amount of vendor code from that needed a lot of 
massaging before it would play nice with support for similar boards from 
other vendors--not to mention how ugly it looked with all the 
board-specific ifdefs.

Chris
