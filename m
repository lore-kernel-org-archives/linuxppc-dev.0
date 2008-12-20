Return-Path: <glikely@secretlab.ca>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.189])
	by ozlabs.org (Postfix) with ESMTP id 6FD4ADDEF1
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Dec 2008 17:45:32 +1100 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so1089528rnf.16
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Dec 2008 22:45:07 -0800 (PST)
Message-ID: <fa686aa40812192235q6d9e09bav80508cf31bf0be94@mail.gmail.com>
Date: Fri, 19 Dec 2008 23:35:07 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: mingqian <xilinx@live.cn>
Subject: Re: Linux 2.6 frame buffer for XUPV2P
In-Reply-To: <BAY105-DS3567863497ABB33F27B64CDF10@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <BAY105-DS3567863497ABB33F27B64CDF10@phx.gbl>
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

2008/12/19 mingqian <xilinx@live.cn>:
> Hi all, I have run Linux 2.6 from git.xilinx.com on my XUPV2P board. This
> vendor kernel version is 2.6.28-rc6. Currently, the uartlite and ethernet
> mac work ok, but xilinx frame buffer driver seems not working, as nothing
> is shown on the VGA monitor, and nothing related to framebuffer is shown in
> the serial output. I run fbset,  but it says fb0 not found.
> The hardware framebuffer IP core I use is the plb_tft_cntlr_ref
> 1.00.d, which is a PLB master and DCR slave, and the  opb2dcr_bridge acts as
> the DCR master.
> Can someone suggest where the problem might be?

Please post your kernel .config and your dmesg output.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
