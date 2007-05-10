Return-Path: <jreiser@BitWagon.com>
Received: from ruby.spiritone.com (ruby.spiritone.com [216.99.193.130])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3B145DDE1F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 May 2007 00:45:30 +1000 (EST)
Message-ID: <46433008.5070508@BitWagon.com>
Date: Thu, 10 May 2007 07:45:28 -0700
From: John Reiser <jreiser@BitWagon.com>
MIME-Version: 1.0
To: pjmaiya <pjmaiya@signal-networks.com>
Subject: Re: RTC drift in PPC
References: <010001c792f4$a5d3dfb0$4601a8c0@signet>
In-Reply-To: <010001c792f4$a5d3dfb0$4601a8c0@signet>
Content-Type: text/plain; charset=ISO-8859-1
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

> We are running RTC on mpc860 board with external crystal...
> We are getting 4 minutes drift for 21 hours.

A slowdown in the approx. range 1:300 to 1:350 is endemic to linux ppc:
http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=157581

-- 
