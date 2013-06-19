Return-Path: <tony.luck@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by ozlabs.org (Postfix) with ESMTP id 125AA2C016F
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Jun 2013 04:46:49 +1000 (EST)
From: "Luck, Tony" <tony.luck@intel.com>
To: Michael Neuling <mikey@neuling.org>, Aruna Balakrishnaiah
 <aruna@linux.vnet.ibm.com>
Subject: RE: [PATCH v4 0/8] Nvram-to-pstore
Date: Wed, 19 Jun 2013 18:46:45 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F2DA88179@ORSMSX106.amr.corp.intel.com>
References: <20130605184756.25794.43872.stgit@aruna-ThinkPad-T420>
 <1822.1371622503@ale.ozlabs.ibm.com> <51C150D8.2070706@linux.vnet.ibm.com>
 <5493.1371623906@ale.ozlabs.ibm.com>
In-Reply-To: <5493.1371623906@ale.ozlabs.ibm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "jkenisto@linux.vnet.ibm.com" <jkenisto@linux.vnet.ibm.com>,
 "keescook@chromium.org" <keescook@chromium.org>,
 "mahesh@linux.vnet.ibm.com" <mahesh@linux.vnet.ibm.com>,
 "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "paulus@samba.org" <paulus@samba.org>, "anton@samba.org" <anton@samba.org>,
 "ccross@android.com" <ccross@android.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> You need to mount pstore to access the files.
>=20
> # mkdir /dev/pstore
> # mount -t pstore - /dev/pstore
>=20
> to unmount
>=20
> # umount /dev/pstore
>=20
> References: http://lwn.net/Articles/421297/

Note that /dev/pstore has fallen out of fashion as the mount point ... we n=
ow (since 3.9)
suggest /sys/fs/pstore

> Documentation/ABI/testing/pstore

This file was updated with the new location.

-Tony
=20
