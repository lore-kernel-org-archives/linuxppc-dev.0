Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc3-s41.bay0.hotmail.com (bay0-omc3-s41.bay0.hotmail.com
	[65.54.246.241]) by ozlabs.org (Postfix) with ESMTP id 94921DDE24
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Sep 2007 17:39:48 +1000 (EST)
Message-ID: <BAY138-F271854679106F05A7C7117B2B80@phx.gbl>
In-Reply-To: <12745876.post@talk.nabble.com>
From: "Ming Liu" <eemingliu@hotmail.com>
To: jqhu936@yahoo.com, linuxppc-embedded@ozlabs.org
Subject: RE: Ethernet adapter not found in Xilinx ppc, with linux 2.6.22
Date: Tue, 18 Sep 2007 07:39:42 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
>
>After several days of struggling I'm now able to boot the linux 2.6.22 and
>run the busybox-1.7.1 root system.  Yet I could not find the Ethernet
>adapter using Xilinx GMAC core.  Pretty sure that I've chosen the 10/100
>Ethernet drivers.  Should I use the Xilinx driver xemac, or other drivers,
>or any other way to apply a patch?

If you are using gigabit ethernet, you must have the corresponding driver 
(gigabit or tri-state) instead of 10/100 one included. 

BR
Ming

_________________________________________________________________
√‚∑—œ¬‘ÿ MSN Explorer:   http://explorer.msn.com/lccn/  
