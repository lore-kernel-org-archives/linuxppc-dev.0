Return-Path: <joerg.roedel@osrc.amd.com>
Date: Wed, 4 Aug 2010 15:16:34 +0200
From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: 2.6.35-stable/ppc64/p7: Badness at lib/dma-debug.c:902, Call
	Trace	& Instruction Dump during boot
Message-ID: <20100804131634.GX26098@amd.com>
References: <1280746270.15317.16.camel@subratamodak.linux.ibm.com>
	<20100802205404C.fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20100802205404C.fujita.tomonori@lab.ntt.co.jp>
Cc: "sachinp@linux.vnet.ibm.com" <sachinp@linux.vnet.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"santil@us.ibm.com" <santil@us.ibm.com>,
	"Linuxppc-dev@ozlabs.org" <Linuxppc-dev@ozlabs.org>,
	"devilbis@us.ibm.com" <devilbis@us.ibm.com>,
	"James.Bottomley@suse.de" <James.Bottomley@suse.de>,
	"sleddog@us.ibm.com" <sleddog@us.ibm.com>,
	"brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>,
	"tj@kernel.org" <tj@kernel.org>,
	"subrata@linux.vnet.ibm.com" <subrata@linux.vnet.ibm.com>,
	"dipraksh@linux.vnet.ibm.com" <dipraksh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 02, 2010 at 07:55:03AM -0400, FUJITA Tomonori wrote:
> I guess that this driver does a partial sync with
> dma_sync_single_for_* API. dma-debug can't handle it properly. It's
> likely that this is a false warning.

If this turns out to be true it is not trivial to fix. I prepare a patch
to test for you.

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
