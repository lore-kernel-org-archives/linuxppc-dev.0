From: Peter Bergner <bergner@brule.borg.umn.edu>
Date: Fri, 12 Oct 2001 11:26:19 -0500
To: Tom Rini <trini@kernel.crashing.org>
Cc: Val Henson <val@nmt.edu>,
	Michael Sokolov <msokolov@ivan.Harhan.ORG>,
	linuxppc-dev@lists.linuxppc.org, Paul Mackerras <paulus@samba.org>
Subject: Re: SBS Palomar II/IV/V port
Message-ID: <20011012112619.A281146@brule.borg.umn.edu>
Reply-To: bergner@vnet.ibm.com
References: <0110092125.AA22665@ivan.Harhan.ORG> <20011010122415.A22918@boardwalk> <20011011161848.B21564@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011011161848.B21564@cpe-24-221-152-185.az.sprintbbd.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


: Okay, does the following look right/work for everyone?  (With a similar
: change to arch/ppc64/kernel/setup.c).
:
: ===== arch/ppc/kernel/setup.c 1.60 vs edited =====
: --- 1.60/arch/ppc/kernel/setup.c	Thu Sep 27 09:01:14 2001
: +++ edited/arch/ppc/kernel/setup.c	Thu Oct 11 16:15:45 2001
: @@ -496,7 +496,7 @@
:  #ifdef CONFIG_BLK_DEV_INITRD
:  		case BI_INITRD:
:  			initrd_start = data[0];
: -			initrd_end = data[0] + rec->size;
: +			initrd_end = data[0] + data[1];
:  			break;
:  #endif /* CONFIG_BLK_DEV_INITRD */
:  #ifdef CONFIG_ALL_PPC

That's one of the changes I already have for PPC64, so looks good to me too.

Peter

--
Peter Bergner
SLIC Optimizing Translator Development / Linux PPC64 Kernel Development
IBM Rochester, MN
bergner@vnet.ibm.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
