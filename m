Return-Path: <tony.luck@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by ozlabs.org (Postfix) with ESMTP id CD6AC2C0091
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Aug 2013 09:43:00 +1000 (EST)
From: "Luck, Tony" <tony.luck@intel.com>
To: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>, "linuxppc-dev@ozlabs.org"
 <linuxppc-dev@ozlabs.org>, "paulus@samba.org" <paulus@samba.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "keescook@chromium.org" <keescook@chromium.org>
Subject: RE: [PATCH 00/11] Add compression support to pstore
Date: Thu, 1 Aug 2013 23:42:56 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F31CAA167@ORSMSX106.amr.corp.intel.com>
References: <20130715164844.1520.27771.stgit@aruna-ThinkPad-T420>
 <51FA3B02.7060004@linux.vnet.ibm.com>
In-Reply-To: <51FA3B02.7060004@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "jkenisto@linux.vnet.ibm.com" <jkenisto@linux.vnet.ibm.com>,
 "mahesh@linux.vnet.ibm.com" <mahesh@linux.vnet.ibm.com>,
 "ccross@android.com" <ccross@android.com>, "anton@samba.org" <anton@samba.org>,
 "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>     Could you please review and let me know your comments!!

Skimmed through it today and didn't notice anything I hated.  It built fine=
 - but doesn't seem to be working on top of ERST.  This doesn't seem to be =
your fault though, when I rebuilt a plain 3.11-rc3 it didn't log anything v=
ia pstore either :-(

Will dig some more at it tomorrow.

-Tony
