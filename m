Return-Path: <tmorrison@empirix.com>
Received: from empbedex1.empirix.com (empbedex1.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id 8946FDDF7D
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 09:19:27 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: options for root file system for MPC8548
Date: Tue, 30 Jan 2007 17:19:15 -0500
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D901064432D9@EMPBEDEX.empirix.com>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I've seen a couple threads about root file systems and such,=20
but I am hoping this is slightly more detailed in what I am=20
looking for!

What is the best means to generate/use/support a root file system?

I can download and use ELDK to generate one, but it doesn't look
like it has all the library / utility package support required by
my application (e.g.: perl).

We do NOT want to use LTIB (supplied by Freescale) to create one=20
(for multiple reasons - including the same as ELDK).

I could purchase one via RedHat or MontaVista (but they are=20
expensive and their kernel support is behind).
=20
Has anyone any experience with LinuxLink (TimeSys)
http://lldn.timesys.com.
It looks promising - but I'd like to hear if others have used them?

Thanks in advance!

Tom Morrison
Principal Software Engineer


EMPIRIX=20
20 Crosby Drive - Bedford, MA  01730
p: 781.266.3567 f: 781.266.3670=20
email: tmorrison@empirix.com=20
www.empirix.com
