Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 732E92C00C9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Aug 2012 23:12:32 +1000 (EST)
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [PATCH] rapidio: apply RX/TX enable to active switch ports only
Date: Mon, 27 Aug 2012 13:01:00 +0000
Message-ID: <8D983423E7EDF846BB3056827B8CC5D12E7C2C91@corpmail1.na.ads.idt.com>
References: <1345559035-25879-1-git-send-email-alexandre.bounine@idt.com>
 <1345559035-25879-2-git-send-email-alexandre.bounine@idt.com>
 <20120824140419.2b3a9623.akpm@linux-foundation.org>
In-Reply-To: <20120824140419.2b3a9623.akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday, August 24, 2012 5:04 PM
Andrew Morton <akpm@linux-foundation.org>
>=20
> On Tue, 21 Aug 2012 10:23:55 -0400
> Alexandre Bounine <alexandre.bounine@idt.com> wrote:
>=20
>> Modify RIO enumeration to apply RX/TX enable operations only to
>> active switch ports. This will leave inactive ports in condition consist=
ent
>> with their state.
>=20
> It's unclear (to me) what the effects of this are.  Does it fix some
> user-visible malfunction?  Or is it just some nice-to-have thing?  Or
> what?
>=20

This patch was intended to keep inactive switch ports with inbound and
outbound packet transfers disabled to block unexpected packets during
hot insertion event. While it does not fix any visible malfunction it
was intended to prevent such events in future.  =20

Since this patch was published it was brought to my attention that some
existing switches may require inbound and outbound ports enabled for
inactive ports as well (not spec compliant).
Therefore, please remove this patch from your tree.    =20

>> This patch is applicable to kernel versions starting from v2.6.35.
>=20
> Is that a recommendation that such a backport be performed?  If so,
> please provide the reasoning.
