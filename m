Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.210.179]) by ozlabs.org (Postfix) with ESMTP id E5FEFB6F19
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 14:32:26 +1100 (EST)
Received: by yxe9 with SMTP id 9so5043415yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 22 Nov 2009 19:32:24 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091121212047.GA29715@yookeroo>
References: <5eb65910911211046q433072f1nd2a6eb955593a37a@mail.gmail.com>
	<20091121212047.GA29715@yookeroo>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 22 Nov 2009 20:32:04 -0700
Message-ID: <fa686aa40911221932v306dd8b5v16434e7e0a1d6ff5@mail.gmail.com>
Subject: Re: DTS for PowerPC 440 based board
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Vinayak Kale <vinayak.kale@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Nov 21, 2009 at 2:20 PM, David Gibson
<david@gibson.dropbear.id.au> wrote:
> On Sun, Nov 22, 2009 at 12:16:59AM +0530, Vinayak Kale wrote:
>> 2) If uboot passes BDInfo struct to kernel instead of DT blob, then in t=
his
>> case does kernel creates FDT at run time?
>
> Not exactly. =A0In this case the bootwrapper will be built with an FDT
> (compiled from a dts) built in. =A0It will however tweak the FDT with
> information from the BDInfo before booting the kernel proper.

...but if you have any sort of choice, save yourself some trouble and
enable FDT support in u-boot.  Then you don't need to muck about with
problematic bd_info structures.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
