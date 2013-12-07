Return-Path: <ruchika.k@servergy.com>
Received: from mail-ob0-f177.google.com (mail-ob0-f177.google.com
 [209.85.214.177])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2D0F02C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Dec 2013 00:26:28 +1100 (EST)
Received: by mail-ob0-f177.google.com with SMTP id va2so1950939obc.8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Dec 2013 05:26:25 -0800 (PST)
Received: from [10.0.0.5] (pool-71-164-229-51.dllstx.fios.verizon.net.
 [71.164.229.51])
 by mx.google.com with ESMTPSA id hl3sm4030738obb.0.2013.12.07.05.26.24
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Sat, 07 Dec 2013 05:26:24 -0800 (PST)
Message-ID: <52A321FF.4090802@servergy.com>
Date: Sat, 07 Dec 2013 07:26:23 -0600
From: Ruchika <ruchika.k@servergy.com>
MIME-Version: 1.0
CC: linuxppc-dev@lists.ozlabs.org
Subject: questions: second of the 2 pcie controllers does not scan the bus.
References: <Pine.LNX.4.64.1311041649250.4290@digraph.polyomino.org.uk>
 <Pine.LNX.4.64.1311041651390.4290@digraph.polyomino.org.uk>
 <1385159644.1403.532.camel@snotra.buserror.net>
 <Pine.LNX.4.64.1311230053360.12354@digraph.polyomino.org.uk>
 <1386376365.7375.209.camel@snotra.buserror.net>
 <52A2706A.7030205@servergy.com>
In-Reply-To: <52A2706A.7030205@servergy.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Any ideas/pointers anyone ?
Thank you
On 12/6/2013 6:48 PM, Ruchika wrote:
>
> Hi,
> I am working with an p4080 based board. I am trying to get 2 PCIE
> controllers probed properly.
>
> In uboot I have no problems scanning and discovering what is connected
> to both controllers/PCI bridges.
>
> For both PCIE1/2 uboot sets up the Primary, secondary and Subordinate
> bus numbers to 0,1,1 respectively.
>
> When linux boots up and probes the controllers, PCIE1 is probed and the
> bridge scanned properly but PCIE2 is probed at the bridge but not
> attempted a scan.
> I see this message
> "pci 0001:02:00.0: bridge configuration invalid ([bus 01-01]),
> reconfiguring
> "
>
> I updated uboot to set the secondary and subordinate numbers to 2 (left
> the primary number to 0) and a subsequent kernel boot scanned the bus
> for PCIE2 successfully.
> I found these numbers to be very critical since the device tree blob
> (bus-range) for pci is also based off these.
>
> I'd like to get a good fix rather than the uboot hack and get better
> understanding of the problem. If there are any pointers someone could
> provide it would be awesome.
>
> Thank you
> Regards
> Ruchika
>
>
>
