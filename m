Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.236])
	by ozlabs.org (Postfix) with ESMTP id 90AFDDDDE7
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Dec 2008 01:40:12 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so20113rvb.9
	for <linuxppc-dev@ozlabs.org>; Fri, 05 Dec 2008 06:40:10 -0800 (PST)
Message-ID: <fa686aa40812050640m4b4afe2egef638ca950cff041@mail.gmail.com>
Date: Fri, 5 Dec 2008 07:40:09 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: s104259@yahoo.it
Subject: Re: usb/eth DTS nodes for custom board based on mpc5200
In-Reply-To: <504269.31435.qm@web23108.mail.ird.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <504269.31435.qm@web23108.mail.ird.yahoo.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 5, 2008 at 4:22 AM, Angelo <s104259@yahoo.it> wrote:
> Hi all.
>
> I'd like to know if it's necessary to modify my DTS.
>
> On my board I have:
> * u-boot 1.2.0
> * kernel 2.6.21
> * arch=powerpc
> * dts based on lite5200b.dts
> * USB port (USB2) configured on the Ethernet port
>
> Is it necessary to combine Ethernet and usb nodes into the device tree
> source?

No.  Configuring the Ethernet pins for USB IO is just a pin routing
board setup task.  You do need to make sure U-Boot sets up the
port_config register correctly, but it doesn't impact the device tree.
 You don't need to change any of the values in the USB node.

However, if the Ethernet device is unused then you should remove the
Ethernet node from your device tree.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
