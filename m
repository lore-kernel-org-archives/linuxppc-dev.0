Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6B224B6F72
 for <linuxppc-dev@ozlabs.org>; Sat, 29 Oct 2011 04:52:23 +1100 (EST)
Subject: Re: [RFC][PATCH 2/2] Example to show use of uio pgprot
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20111028163706.GB27444@kroah.com>
Date: Fri, 28 Oct 2011 12:52:01 -0500
Message-Id: <A42590B4-A0D4-433D-ADA8-57ECBFAB9A6E@kernel.crashing.org>
References: <1319817030-23992-1-git-send-email-galak@kernel.crashing.org>
 <1319817030-23992-2-git-send-email-galak@kernel.crashing.org>
 <20111028163706.GB27444@kroah.com>
To: Greg KH <greg@kroah.com>
Cc: linuxppc-dev@ozlabs.org, hjk@hansjkoch.de, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 28, 2011, at 11:37 AM, Greg KH wrote:

> On Fri, Oct 28, 2011 at 10:50:30AM -0500, Kumar Gala wrote:
>> ---
>> drivers/uio/uio_dpa.c |  200 =
+++++++++++++++++++++++++++++++++++++++++++++++++
>> 1 files changed, 200 insertions(+), 0 deletions(-)
>> create mode 100644 drivers/uio/uio_dpa.c
>=20
> You do realize this does not build, right?
>=20
> thanks,
>=20
> greg k-h

Yes, it was meant to show Hans and example of why we need to allow a UIO =
driver to set its own pgprot.  We plan on upstream all that code, but =
wanted at least to get feedback on the general UIO change.

- k=
