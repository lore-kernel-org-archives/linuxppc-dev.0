Return-Path: <rdreier@cisco.com>
Received: from sj-iport-1.cisco.com (sj-iport-1-in.cisco.com [171.71.176.70])
	by ozlabs.org (Postfix) with ESMTP id 2A26967BAD
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Oct 2006 03:18:31 +1000 (EST)
To: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
Subject: Re: [PATCH 2.6.19-rc1] ehca: fix ehca_probe if module loaded after
	ib_ipoib
References: <200610021908.52695.hnguyen@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 02 Oct 2006 10:18:29 -0700
In-Reply-To: <200610021908.52695.hnguyen@de.ibm.com> (Hoang-Nam Nguyen's
	message of "Mon, 2 Oct 2006 19:08:52 +0200")
Message-ID: <adamz8ews9m.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	openib-general@openib.org, openfabrics-ewg@openib.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Looks OK but your mailer mangled the patch.  Please resend in a form
that can be applied...

Also:

 > In addition to that this patch contains a very small format improvement 
 > in our tracing function.

please send unrelated changes as separate patches.
So this should come as two patches -- one to fix the device
registration, and one to change your debug formatting.

Thanks,
  Roland
