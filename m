Return-Path: <olaf@aepfle.de>
Received: from mo6-p00-ob.rzone.de (mo6-p00-ob.rzone.de
 [IPv6:2a01:238:20a:202:5300::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8FA3A2C0080
 for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2012 05:06:18 +1000 (EST)
Date: Mon, 30 Jul 2012 21:06:06 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] scsi/ibmvscsi: add module alias for ibmvscsic
Message-ID: <20120730190606.GD3155@aepfle.de>
References: <1342630158-16510-1-git-send-email-olaf@aepfle.de>
 <1343611946.21647.23.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1343611946.21647.23.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Brian J King <bjking1@us.ibm.com>,
 "James E.J. Bottomley" <JBottomley@parallels.com>, linux-scsi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 30, Benjamin Herrenschmidt wrote:

> On Wed, 2012-07-18 at 18:49 +0200, olaf@aepfle.de wrote:
> > From: Olaf Hering <olaf@aepfle.de>
> > 
> > The driver is named ibmvscsic, at runtime it its name is advertised as
> > ibmvscsi. For this reason mkinitrd wont pickup the driver properly.
> > Reported by IBM during SLES11 beta testing:
> > 
> > https://bugzilla.novell.com/show_bug.cgi?id=459933
> > LTC50724
> 
> So while this would work, I do wonder however whether we could instead
> fix it by simplifying the whole thing as follow since iSeries is now
> gone and so we don't need split backends anymore:
> 
> scsi/ibmvscsi: Remove backend abstraction

I cant that these things myself anymore.

Olaf
