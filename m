Return-Path: <geoff@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:4830:2446:ff00:4687:fcff:fea6:5117])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 398C12C02C5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2013 07:56:15 +1100 (EST)
Message-ID: <1360616160.4852.7.camel@smoke>
Subject: Re: Re[2]: PS3 platform is broken on Linux 3.7.0
From: Geoff Levand <geoff@infradead.org>
To: Phileas Fogg <phileas-fogg@mail.ru>
Date: Mon, 11 Feb 2013 12:56:00 -0800
In-Reply-To: <1360486777.923599245@f85.mail.ru>
References: <1355488506.55692113@f147.mail.ru>
 <1357956742.20936.11.camel@smoke> <1358206641.4489.8.camel@smoke>
 <1360486777.923599245@f85.mail.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-02-10 at 12:59 +0400, Phileas Fogg wrote:
> i found where the problem lies.
...
> And that's why lv1_insert_htab_entry fails with -17 which means LV1_ILLEGAL_PARAMETER_VALUE because
> the Hypervisor of PS3 checks 'AVPN' values for number of leading zeros and allows at least 15 bits which in case
> of 'v' value 25008684d8001 is too small of course.

Excellent work, thanks for debugging!

-Geoff
