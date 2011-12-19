Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:32:0:1:25:1])
 by ozlabs.org (Postfix) with ESMTP id 832CFB703F
 for <linuxppc-dev@ozlabs.org>; Mon, 19 Dec 2011 19:08:41 +1100 (EST)
Date: Mon, 19 Dec 2011 09:08:27 +0100
From: Anatolij Gustschin <agust@denx.de>
To: liguohu <liguohu@live.com>
Subject: Re: Help needed with porting ether-net driver from ADS5121 to
 TWR-MPC5125
Message-ID: <20111219090827.79997677@wker>
In-Reply-To: <BLU0-SMTP14243F8B3BC45B200DD0EF8C6A00@phx.gbl>
References: <BLU0-SMTP14243F8B3BC45B200DD0EF8C6A00@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Fri, 16 Dec 2011 08:38:58 +0800
G.H.Lee <liguohu@live.com> wrote:
...
> I am a new user of the board TWR-MPC5125 made by freescale. Now I am trying to porting the new kernel, i.e. the version 3.0.4, to this board. I have porting the serial driver and the nand flash driver successfully. And I can also mount the root file system. But I can not use the ether-net interface now. I have tried to port the ether-net driver based on the ether-net driver for ADS 5121, which is provided by the new kernel 3.0.4. The only thing I have to do in the porting is that I should change the MII mode in ADS5121 board to RMII mode in my board. And I find that I can send packages out if I use the "ping" command. But I can not receive any package for responding. And I also found that the interrupt routine for sending packages was running but the interrupt routine for receiving message was not called by the kernel. I don't know why. 
> 
> Can anyone help me? Should I change some other codes beyond the ether-net driver? Someone told me that I should regulate the kernel because of the differences among the different kerenl versions if the MAC was integrated inside the SOC, which was the fatto in my board. But I don't know how to regulate.

Please try following patch for fs_enet driver:
http://patchwork.ozlabs.org/patch/87320/

There are also other patches for TWR-MPC5125 support:
http://patchwork.ozlabs.org/patch/87925/
http://patchwork.ozlabs.org/patch/87926/
http://patchwork.ozlabs.org/patch/87321/

Thanks,
Anatolij
