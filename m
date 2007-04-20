Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id CE974DDDF3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Apr 2007 17:19:05 +1000 (EST)
Message-ID: <46286A0F.9080608@grandegger.com>
Date: Fri, 20 Apr 2007 09:21:51 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: FDT for MPC5200, CPU revision, MSCAN
References: <462864CA.7050601@grandegger.com>
In-Reply-To: <462864CA.7050601@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Wolfgang Grandegger wrote:
> Hello,
> 
> is there a way to distinguish the CPU revision (Rev.A vs. Rev.B) of the 
> MPC5200, preferably at run time? Or should this be defined in the FDT?
> I ask, because some settings depend on the CPU revision due to hardware 
> bugs, like the clock source used for MSCAN.

I found the information here:

$ cat Documentation/powerpc/mpc52xx-device-tree-bindings.txt
...
The 5200B is almost the same as the 5200, but not quite.  It fixes
silicon bugs and it adds a small number of enhancements.  Most of the
devices either provide exactly the same interface as on the 5200.  A few
devices have extra functions but still have a backwards compatible mode.
To express this infomation as completely as possible, 5200B device trees
should have two items in the compatible list;
"mpc5200b-<device>\0mpc5200-<device>".  It is *strongly* recommended
that 5200B device trees follow this convention (instead of only listing
the base mpc5200 item).
...

Sorry for the noise.

Wolfgang.
