Return-Path: <robert.richter@amd.com>
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
	[216.32.180.14]) by ozlabs.org (Postfix) with ESMTP id 6B4AEB7D71
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jun 2010 20:13:34 +1000 (EST)
Date: Fri, 4 Jun 2010 11:58:16 +0200
From: Robert Richter <robert.richter@amd.com>
To: Denis Kirjanov <dkirjanov@hera.kernel.org>
Subject: Re: [PATCH] powerpc/oprofile: fix potential buffer overrun in
	op_model_cell.c
Message-ID: <20100604095816.GB21799@erda.amd.com>
References: <20100601194334.GA4549@hera.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20100601194334.GA4549@hera.kernel.org>
Cc: "arnd@arndb.de" <arnd@arndb.de>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"paulus@samba.org" <paulus@samba.org>, "jkosina@suse.cz" <jkosina@suse.cz>,
	"oprofile-list@lists.sf.net" <oprofile-list@lists.sf.net>,
	"cel@us.ibm.com" <cel@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01.06.10 15:43:34, Denis Kirjanov wrote:
> Fix potential initial_lfsr buffer overrun.
> Writing past the end of the buffer could happen when index == ENTRIES
> 
> Signed-off-by: Denis Kirjanov <dkirjanov@kernel.org>

Patch applied to

 git://git.kernel.org/pub/scm/linux/kernel/git/rric/oprofile.git urgent

Thanks Denis.

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
email: robert.richter@amd.com
