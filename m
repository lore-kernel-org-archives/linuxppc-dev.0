Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 29898DDE24
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 21 Dec 2008 14:59:00 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so536140yxg.39
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Dec 2008 19:58:59 -0800 (PST)
Message-ID: <fa686aa40812201958k5358d81wac30662517c59d@mail.gmail.com>
Date: Sat, 20 Dec 2008 20:58:58 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: mingqian <xilinx@live.cn>
Subject: Re: Linux 2.6 frame buffer for XUPV2P
In-Reply-To: <BAY105-DS32759F571CA31E6361531CDEE0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <BAY105-DS3567863497ABB33F27B64CDF10@phx.gbl>
	<fa686aa40812192235q6d9e09bav80508cf31bf0be94@mail.gmail.com>
	<BAY105-DS5483ABB21548C3078681CCDF10@phx.gbl>
	<fa686aa40812201245q5a04cf39x62f20be2bba69b8@mail.gmail.com>
	<BAY105-DS32759F571CA31E6361531CDEE0@phx.gbl>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, Dec 20, 2008 at 6:34 PM, mingqian <xilinx@live.cn> wrote:
> Hi Grant, thank you for your quick reply:-)
> Here is my dts:

Try the following things:

1) Change the following line in the dts:
> compatible = "xlnx,plb-tft-cntlr-ref-1.00.d";

to 'compatible = "xlnx,plb-tft-cntlr-ref-1.00.a";'

2) add '#define DEBUG' to the top of drivers/video/xilinxfb.c before
the first #include statement and post the dmesg output.

3) look in /sys/bus/of_platform/devices to see if there is a directory
for the xilinx framebuffer device.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
