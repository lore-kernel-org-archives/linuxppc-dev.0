Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc3-s14.bay0.hotmail.com (bay0-omc3-s14.bay0.hotmail.com
	[65.54.246.214]) by ozlabs.org (Postfix) with ESMTP id 3F5E4DDDEC
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Feb 2007 00:10:58 +1100 (EST)
Message-ID: <BAY110-F303F426CC4D6243140830EB2920@phx.gbl>
In-Reply-To: <406A31B117F2734987636D6CCC93EE3CB05886@ehost011-3.exch011.intermedia.net>
From: "Ming Liu" <eemingliu@hotmail.com>
To: Leonid@a-k-a.net
Subject: RE: Linux on ML403
Date: Sun, 11 Feb 2007 13:10:50 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
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

Hi,
>From http://source.mvista.com/ you can get the kernel of 
linux-xilinx-26.git.

The Temac driver is provided along with Xilinx EDK. So just overwrite the 
corresponding files and try to compile. It will not be strange if there are 
some errors. So just debug it. 

Good luck.

BR
Ming


>From: "Leonid" <Leonid@a-k-a.net>
>To: <linuxppc-embedded@ozlabs.org>
>Subject: Linux on ML403
>Date: Sat, 10 Feb 2007 22:55:27 -0800
>
>Folks, is everybody using Monta Vista Linux on ML403, or there are
>those, using standard kernel from kernel.org? Or any other place I can
>get 2.6 kernel for free.
>
>I would also appreciate any instructions how to patch it for TMAC if
>necessary.
>
>Thanks,
>
>Leonid.
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded

_________________________________________________________________
√‚∑—œ¬‘ÿ MSN Explorer:   http://explorer.msn.com/lccn/  
