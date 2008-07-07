Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.249])
	by ozlabs.org (Postfix) with ESMTP id 797CDDED98
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 00:31:10 +1000 (EST)
Received: by ag-out-0708.google.com with SMTP id 8so13163966agc.0
	for <linuxppc-dev@ozlabs.org>; Mon, 07 Jul 2008 07:31:09 -0700 (PDT)
Message-ID: <fa686aa40807070731y52d21f49jc7ced0aaf8e5d029@mail.gmail.com>
Date: Mon, 7 Jul 2008 08:31:08 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Linn" <John.Linn@xilinx.com>
Subject: Re: Please pull linux-2.6-virtex.git
In-Reply-To: <20080707142652.43C32110807E@mail204-va3.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080704172240.GE17062@secretlab.ca>
	<1215433036.20774.39.camel@weaponx>
	<20080707141332.6CDD313E8050@mail111-sin.bigfish.com>
	<20080707142652.43C32110807E@mail204-va3.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 7, 2008 at 8:26 AM, John Linn <John.Linn@xilinx.com> wrote:
> Where should I be looking to understand what's needed for dts-v1 format?
>
> I did a quick review of Doc*/powerpc/booting-wihtout-of.txt and didn't
> see it, but maybe I overlooked it.

Primarily all hex values need to be change to the form '0x???' instead
of '???' and '/dtc-v1' needs to be added to the beginning of the file.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
