Return-Path: <mamsadegh@hotmail.com>
Received: from bay0-omc2-s27.bay0.hotmail.com (bay0-omc2-s27.bay0.hotmail.com
	[65.54.246.163]) by ozlabs.org (Postfix) with ESMTP id 06934DDE06
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 May 2007 19:15:36 +1000 (EST)
Message-ID: <BAY115-W4C8C341511C29C64FA72AB23B0@phx.gbl>
From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
To: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
Subject: Xilinx OPB EMC Linux 2.6 Driver 
Date: Wed, 9 May 2007 09:15:34 +0000
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi All,

I'm going to use intel strata flash chip on ml403 for bringing up my 2.6 ke=
rnel. ( I do not want to use Sys ACE any more )

At the first step I have some simple questions

2.6 Kernel provides a wide range of support for flash devices, from CFI to =
many other types, I can enable any of them I want.=20

But I think that some thing is missing here, There should be a driver to en=
able Extended Memory Controller (OPB EMC) module which is mainly connected =
to the strata flash chip. Is this true? Or the current drivers in the kerne=
l are enough?=20

May be I should enable support for CFI and then I choose CFI in physical me=
mory option?

Thanks.

_________________________________________________________________
Explore the seven wonders of the world
http://search.msn.com/results.aspx?q=3D7+wonders+world&mkt=3Den-US&form=3DQ=
BRE=
