Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f20.google.com (mail-gx0-f20.google.com
	[209.85.217.20]) by ozlabs.org (Postfix) with ESMTP id 4A1E4DDEED
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jan 2009 01:34:14 +1100 (EST)
Received: by gxk13 with SMTP id 13so4515645gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 06:34:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <21589420.post@talk.nabble.com>
References: <21589420.post@talk.nabble.com>
Date: Thu, 22 Jan 2009 07:34:12 -0700
Message-ID: <fa686aa40901220634o795c746ej3364dc3fe7d8a670@mail.gmail.com>
Subject: Re: eth0: Could not attach to PHY
From: Grant Likely <grant.likely@secretlab.ca>
To: wael showair <showair2003@yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 21, 2009 at 11:37 AM, wael showair <showair2003@yahoo.com> wrote:
>
> Hi All,
> i have a board with MPC8555 processor
> uboot version 1.1.6
> linux kernel 2.6.19-rc5
> ltib version: 6.2.2-sv
> gcc 3.4.3
>
> it boots successfully
> i want to upgrade my linux kernel to 2.6.27
> i upgraded the following:
> ltib version 8.1.2-sv
> gcc 4.1
> linux kernel 2.6.27
> & i kept the uboot with the same version 1.1.6
>
> the kernel booting stucks as follows:

You probably need to add an mdio node to your device tree and add a
phy-handle to the ethernet node.  See powerpc/boot/dts/mpc8555cds.dts
for an example.  (Look at the mdio@25520 and ethernet@24000 nodes)

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
