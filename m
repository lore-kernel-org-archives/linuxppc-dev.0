Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18744.25938.847656.411651@cargo.ozlabs.ibm.com>
Date: Fri, 5 Dec 2008 10:18:42 +1100
From: Paul Mackerras <paulus@samba.org>
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] powerpc: Check for valid hugepage size in
	hugetlb_get_unmapped_area
In-Reply-To: <4938626A.5070801@linux.vnet.ibm.com>
References: <200812041408.mB4E8fRV002401@d01av03.pok.ibm.com>
	<18744.25000.311915.697199@cargo.ozlabs.ibm.com>
	<4938626A.5070801@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, kniht@linux.vnet.ibm.com, agl@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Brian King writes:

> This should go to Linus for 2.6.28

OK, thanks, but is it a regression from 2.6.27?

(Serves me right for asking two questions in one email. :)

Paul.
