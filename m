Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4A76D2C008D
 for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2012 10:20:38 +1000 (EST)
Message-ID: <1343607613.21647.9.camel@pasglop>
Subject: Re: [PATCH] scsi/ibmvscsi: /sys/class/scsi_host/hostX/config
 doesn't show any information
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Mon, 30 Jul 2012 10:20:13 +1000
In-Reply-To: <1343372206.3323.24.camel@dabdike>
References: <1342630157-16468-1-git-send-email-olaf@aepfle.de>
 <1343366362.2118.15.camel@pasglop> <1343372206.3323.24.camel@dabdike>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, olaf@aepfle.de, Linda Xie <lxiep@us.ibm.com>,
 linux-scsi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-07-27 at 07:56 +0100, James Bottomley wrote:
> On Fri, 2012-07-27 at 15:19 +1000, Benjamin Herrenschmidt wrote:
> > On Wed, 2012-07-18 at 18:49 +0200, olaf@aepfle.de wrote:
> > > From: Linda Xie <lxiep@us.ibm.com>
> > 
> > James, can I assume you're picking up those two ?
> 
> If they get acked by the maintiners ...

I don't think we have a specific upstream maintainer for those drivers,
so let's assume it's my job... NAK on the sysfs one, the other one is
ok, I'll reply to the respective patches.

Cheers,
Ben.
