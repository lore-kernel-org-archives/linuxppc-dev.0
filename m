Return-Path: <maynardj@us.ibm.com>
Message-ID: <455B60E5.2040201@us.ibm.com>
Date: Wed, 15 Nov 2006 12:48:05 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
MIME-Version: 1.0
To: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
	oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC, Patch 0/1] OProfile for Cell: Initial profiling support --
	new patch
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,
I will be posting a patch that updates the OProfile kernel driver to 
enable it for the Cell Broadband Engine processor.  The patch is based 
on Arnd Bergmann's arnd6 patchset for 2.6.18  
(http://kernel.org/pub/linux/kernel/people/arnd/patches/2.6.18-arnd6/), 
with Kevin Corry's cbe_pmu_interrupt patch on applied on top.  Kevin 
Corry's patch was submitted to the mailing lists earlier today and can 
be found at:
 http://marc.theaimsgroup.com/?l=linux-kernel&m=116360639928471&w=2).

I will also post an OProfile userpsace patch to the oprofile-list that 
adds the necessary support for the Cell processor.

Thanks in advance for your review of this patch.

Maynard Johnson
LTC Power Linux Toolchain
507-253-2650
