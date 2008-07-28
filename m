Return-Path: <SSparks@aclaratech.com>
Received: from SG2EHSOBE004.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id 157D4DEE82
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 04:18:16 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: mpc8349-mITX DTB load failure
Date: Mon, 28 Jul 2008 13:16:50 -0500
Message-ID: <6011A7C9CD0EE74792C3ED2A8355608634214E@mail.twacs.com>
In-Reply-To: <20080728180241.GD21534@secretlab.ca>
References: <6011A7C9CD0EE74792C3ED2A8355608634213E@mail.twacs.com>
	<20080728171634.GB21265@secretlab.ca>
	<6011A7C9CD0EE74792C3ED2A8355608634214C@mail.twacs.com>
	<20080728180241.GD21534@secretlab.ca>
From: "Sparks, Sam" <SSparks@aclaratech.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> From: Grant Likely
> Sent: Monday, July 28, 2008 1:03 PM
> Does your dts source file already have a chosen node?  There=20
> had been an issue where u-boot cacks if chosen was pre-created.

Nope, there is no reference to "chosen" in the dts

--Sam
