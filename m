Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yRFf91lzDzDr25
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Nov 2017 02:30:07 +1100 (AEDT)
Date: Tue, 31 Oct 2017 16:30:05 +0100
From: Torsten Duwe <duwe@lst.de>
To: "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Balbir Singh <bsingharora@gmail.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v3] kernel/module_64.c: Add REL24 relocation support of
 livepatch symbols
Message-ID: <20171031153004.GA31864@lst.de>
References: <1508217523-18885-1-git-send-email-kamalesh@linux.vnet.ibm.com>
 <20171031141959.7pqnlncg2236yqqg@naverao1-tp.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171031141959.7pqnlncg2236yqqg@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 31, 2017 at 07:49:59PM +0530, Naveen N . Rao wrote:
> Hi Kamalesh,
> Sorry for the late review. Overall, the patch looks good to me.

If you're good with a hammer...

Maybe I failed to express my views properly; I find the whole approach
mislead in the first place. I had asked questions previously because it
would have never come to my mind that someone would deliberately, without
a compelling reason, creates broken live patch modules and then tries
to fix them up with some ugly band-aid in the kernel. So for the record:

NAK'd-by: Torsten Duwe <duwe@suse.de>

	Torsten
