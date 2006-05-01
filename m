Return-Path: <rdreier@cisco.com>
Received: from test-iport-1.cisco.com (test-iport-1.cisco.com [171.71.176.117])
	by ozlabs.org (Postfix) with ESMTP id 7493C67B6E
	for <linuxppc-dev@ozlabs.org>; Tue,  2 May 2006 03:13:34 +1000 (EST)
To: Heiko Joerg Schick <info@schihei.de>
Subject: Re: [openib-general] Re: [PATCH 00/16] ehca: IBM eHCA InfiniBand
	Device Driver
References: <4450B378.9000705@de.ibm.com>
	<20060427125726.GK32127@wohnheim.fh-wedel.de>
	<e2r7a0$fo2$1@sea.gmane.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 01 May 2006 10:03:24 -0700
In-Reply-To: <e2r7a0$fo2$1@sea.gmane.org> (Heiko Joerg Schick's message of
	"Thu, 27 Apr 2006 21:50:28 +0200")
Message-ID: <ada8xply8wz.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	openib-general@openib.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

    Heiko> I don't like the idea to put the whole driver in one patch
    Heiko> file. I would propose to put the patch "ehca: integration
    Heiko> in Linux kernel" last instead of first, as Arnd
    Heiko> mentioned. With that change we leave the kernel in a
    Heiko> working state when applying the patches.

Yes, that makes sense.

And I can fold the patches into a single git changeset when we finally
merge it, since I don't see any advantage to having the driver split
into pieces.  (No one is going to git biset a half-applied driver or
anything like that)

 - R.
