Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 5A18B67EC2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Aug 2005 09:20:23 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Wed, 10 Aug 2005 16:20:21 -0700
To: "Thomas S." <thomas@schnuerer-online.de>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Message-ID: <20050810232021.GA8412@xyzzy.farnsworth.org>
References: <42F8E0C9.2050505@softadvances.com>
	<75E0EACF-3C16-45AE-A0D2-CE999AF9AC7B@freescale.com>
	<42FA5932.4070002@schnuerer-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42FA5932.4070002@schnuerer-online.de>
Subject: Re: [linuxppc] 2.6.12-3 header <asm/usb.h> missing ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Aug 10, 2005 at 07:44:50PM +0000, Thomas S. wrote:
> thanks for the Info, that helps. Do you know if in this kernel Version 
> the MPC5200 USB Bug is already handled?
> 
> I refer to errata document MPC5200E.pdf (I think rev. 06/2005) in which 
> its stated that the frame_no and pad1 words are swapped in the 
> processors OHCI Area. I saw in some earlier 2.4 kernel that in 
> /drivers/usb/host/ohci.h the members frame_no and pad1 of struct 
> ohci_hcca were swapped. maybe thats not necessary anymore ?
> 
> Im using this driver to support our embedded system modules equipped 
> with the 5200 (see the EM1 board on www.men.de for specs).

Yes, the swapped frame_no issue is handled in the 2.6 MPC5200 usb
driver.

-Dale
