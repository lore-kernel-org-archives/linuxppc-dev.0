Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 0F6B6DDD1C
	for <linuxppc-dev@ozlabs.org>; Sun, 10 May 2009 06:51:57 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so1163688ywt.39
	for <linuxppc-dev@ozlabs.org>; Sat, 09 May 2009 13:51:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A0457BC.3040408@dlasys.net>
References: <4A0457BC.3040408@dlasys.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 9 May 2009 14:51:35 -0600
Message-ID: <fa686aa40905091351k140c64a0w27eb44908218814@mail.gmail.com>
Subject: Re: device trees.
To: dhlii@dlasys.net
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

On Fri, May 8, 2009 at 10:03 AM, David H. Lynch Jr. <dhlii@dlasys.net> wrot=
e:
> =A0 =A0Is there an example somewhere that shows building a device tree on
> the fly ?
>
> =A0 =A0As our products move forward it becomes increasingly clear that
> static configurations are not going to work.

Knowing your history, I assume you're talking about FPGA device trees
here.  Are you doing partial reconfiguration at runtime?  Or are you
talking about generating a device tree to match the FPGA design?

For the later, there is a tool which works with EDK to generate a
device tree based on an EDK design.  You can find it on the xilinx git
server:

http://git.xilinx.com/cgi-bin/gitweb.cgi?p=3Ddevice-tree.git;a=3Dsummary

To use device tree with partial reconfiguration would require rework
to the device tree infrastructure to prune and graft portions of the
device tree.  I think it is possible, but it is non-trivial to get
working.

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
