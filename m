Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 30624B70AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Oct 2010 00:39:44 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Serial RapidIO Maintaintance read causes lock up
Date: Tue, 5 Oct 2010 06:34:57 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552013B9A9D@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <AANLkTimCiHWRR-kVuT0ift3CH63Xk_XcaXS22qmVh6fr@mail.gmail.com>
References: <0CE8B6BE3C4AD74AB97D9D29BD24E552013B97E8@CORPEXCH1.na.ads.idt.com>
	<AANLkTimCiHWRR-kVuT0ift3CH63Xk_XcaXS22qmVh6fr@mail.gmail.com>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Bastiaan Nijkamp" <bastiaan.nijkamp@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Bastiaan,
=20

Bastiaan Nijkamp <bastiaan.nijkamp@gmail.com> wrote:=20

>fsl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, RIO
Maintainance Window Size >0x400000,New Main Start: 0xd1080000
>RIO: enumerate master port 0, RIO0 mport
>fsl_rio_config_read: index 0 destid 255 hopcount 0 offset 00000068 len
4
... skip ....
>fsl_rio_config_read: triggering '__fsl_read_rio_config'
>fsl_rio_config_read: going to request to read data at d108006

An address printed in the last line looks strange - is this typo or real
value?
I would expect to see d1080068 here if your maintenance window starts at
0xd1080000.

Alex.
