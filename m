Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc1-s27.bay0.hotmail.com (unknown [65.54.246.99])
	by ozlabs.org (Postfix) with ESMTP id BA16E67B65
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Jul 2006 22:30:56 +1000 (EST)
Message-ID: <BAY110-F7C8FCF7212B2C72884335B26F0@phx.gbl>
In-Reply-To: <44B6DC18.9020409@dlasys.net>
From: "Ming Liu" <eemingliu@hotmail.com>
To: dhlii@comcast.net
Subject: RE: Xilinx hard TEMAC
Date: Fri, 14 Jul 2006 12:30:53 +0000
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

Hi David,

>The hardware I have to support is the Hard TEMAC on the LocalLink Bus.
>It is my understanding that this is the TEMAC builtin to the FX parts,
>not one that is created in the FPGA.

That's right. The hard Temac is a built-in hard core in virtex 4 FPGA. 

>Is anyone else working to support that configuration ? I think that is
>basically the same as the GRSD TEMAC.
>Is it sane to try to adapt the soft TEMAC patch from the list ?

I am working on that. But I am not so experienced and still working. :)

>I actually started trying to get the posted TEMAC patch working but that
>quickly went off the rails - I presumed because the hard and soft
>TEMAC's are just too different, or because the xilinx_edk really does
>not support the hard TEMAC.

I don't think so. I think the hard and soft cores are similar. I have 
included the enet drive in Linux 2.4 and it works well. Now I am including 
the Temac in 2.6 and have not see the result. 

>Regardless. I need to get a driver working, and I am not looking to
>duplicate effort.

I am doing that. So we can share our experience. 

Regards
Ming

_________________________________________________________________
√‚∑—œ¬‘ÿ MSN Explorer:   http://explorer.msn.com/lccn/  
