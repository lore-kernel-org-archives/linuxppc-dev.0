Return-Path: <seiji.aguchi@hds.com>
Received: from usindpps04.hds.com (usindpps04.hds.com [207.126.252.17])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B35E92C00B6
 for <linuxppc-dev@ozlabs.org>; Thu,  5 Sep 2013 02:40:41 +1000 (EST)
From: Seiji Aguchi <seiji.aguchi@hds.com>
To: "Luck, Tony" <tony.luck@intel.com>, Aruna Balakrishnaiah
 <aruna@linux.vnet.ibm.com>
Subject: RE: [RFC PATCH v2 04/11] pstore: Add compression support to pstore
Date: Wed, 4 Sep 2013 16:39:23 +0000
Message-ID: <A5ED84D3BB3A384992CBB9C77DEDA4D443E9F05D@USINDEM103.corp.hds.com>
References: <20130816131403.3338.82330.stgit@aruna-ThinkPad-T420>
 <20130816131805.3338.68767.stgit@aruna-ThinkPad-T420>
 <A5ED84D3BB3A384992CBB9C77DEDA4D443E8F0D7@USINDEM103.corp.hds.com>
 <3908561D78D1C84285E8C5FCA982C28F31CC7AC0@ORSMSX106.amr.corp.intel.com>
 <521C36F4.8030607@linux.vnet.ibm.com>
 <A5ED84D3BB3A384992CBB9C77DEDA4D443E9E24D@USINDEM103.corp.hds.com>
 <5226CC9D.30904@linux.vnet.ibm.com>
 <3908561D78D1C84285E8C5FCA982C28F31CDB23E@ORSMSX106.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F31CDB23E@ORSMSX106.amr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "jkenisto@linux.vnet.ibm.com" <jkenisto@linux.vnet.ibm.com>,
 "keescook@chromium.org" <keescook@chromium.org>,
 "mahesh@linux.vnet.ibm.com" <mahesh@linux.vnet.ibm.com>,
 "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "ccross@android.com" <ccross@android.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> But let's make sure that efivars, erst,
> etc. are all happy with the changes we make before I ask Linus to pull an=
other
> pstore piece.

I will test efivars when Aruna posts the bugfix patches.

Seiji

> -----Original Message-----
> From: Luck, Tony [mailto:tony.luck@intel.com]
> Sent: Wednesday, September 04, 2013 12:11 PM
> To: Aruna Balakrishnaiah; Seiji Aguchi
> Cc: jkenisto@linux.vnet.ibm.com; keescook@chromium.org; mahesh@linux.vnet=
.ibm.com; ccross@android.com; linux-
> kernel@vger.kernel.org; linuxppc-dev@ozlabs.org; cbouatmailru@gmail.com
> Subject: RE: [RFC PATCH v2 04/11] pstore: Add compression support to psto=
re
>=20
> > The reason behind compression failure is the size of big_oops_buf which=
 is too
> > big for efivars case. I will do some experiments with different kind of=
 texts
> > for buffer size 1024 to check if 100/53 suits for all the cases.
> ...
>=20
> > Yes this can be changed to zlib_inflateInit2().
>=20
> Original patch series was just pulled by Linus ... so we'll need a patch =
on top
> of current Linus git tree to fix these issues.  But let's make sure that =
efivars, erst,
> etc. are all happy with the changes we make before I ask Linus to pull an=
other
> pstore piece.
>=20
> Thanks
>=20
> -Tony
