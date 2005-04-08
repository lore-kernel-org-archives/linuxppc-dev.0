Return-Path: <rsiemsen@rossvideo.com>
Received: from server06.rossvideo.com (unknown [209.87.241.202])
	by ozlabs.org (Postfix) with ESMTP id 59C4B67A64
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Apr 2005 00:39:46 +1000 (EST)
Message-ID: <425694D5.3000507@rossvideo.com>
Date: Fri, 08 Apr 2005 10:27:33 -0400
From: Ralph Siemsen <rsiemsen@rossvideo.com>
MIME-Version: 1.0
To: Sanjay Bajaj <sbajaj@tsi-telsys.com>
References: <0007F077BB3476449151699150E8FEA20592AF@exchange.tsi-telsys.com>
In-Reply-To: <0007F077BB3476449151699150E8FEA20592AF@exchange.tsi-telsys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: PCI Arbiter on PPC440GX?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sanjay Bajaj wrote:

> How do I enable/disable PCI Arbiter on PPC440GX?

See the UserManual for all the details... but the arbiter enable/disable 
is a strapping option.  If you do not have a serial boot prom, then the 
arbiter is off by default.  You can override this in your bootloader by 
poking a register.  Seach the manual for "PAE" (Pci Arbiter Enable). 
The register is SDR0_XCR, bit #0 (page 347).

-R
