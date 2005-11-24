Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 83523687DE
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Nov 2005 08:26:45 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
In-Reply-To: <200511242214.16365.rjw@sisk.pl>
References: <1132715288.26560.262.camel@gaston>
	<200511242150.23205.rjw@sisk.pl> <1132866088.26560.455.camel@gaston>
	<200511242214.16365.rjw@sisk.pl>
Content-Type: text/plain
Date: Fri, 25 Nov 2005 08:22:22 +1100
Message-Id: <1132867342.26560.461.camel@gaston>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Fix USB suspend/resume crasher
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> 
> FWIW, does the appended change look reasonable to you?  (It apparently
> helps. ;-))

Yes. I was about to do a new patch after I finish my breakfast, but
yours applied on top of Greg's merged one works too.

Ben.
