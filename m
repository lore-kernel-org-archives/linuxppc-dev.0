Return-Path: <tmorrison@empirix.com>
Received: from empbedex1.empirix.com (empbedex1.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id 78685DE2D3
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 09:53:22 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: MPC8548E w/ 4 Gig of DDR SDRAM 
Date: Thu, 25 Jan 2007 17:53:13 -0500
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D90106334E77@EMPBEDEX.empirix.com>
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

Firstly, excuse my ignorance, I have looked at the archives to see=20
if there was any mention of a subject like this - but I could NOT=20
find a relevant one - so I ask forgiveness if I missed a thread=20
discussing this - and/or if this is a real newbie question!
=20
I have MPC8548E with 4 Gig of DDR SDRAM.

I am trying to figure out how to configure the MPC8548 & its=20
Local Access Windows (and ?? what else) for 4 Gig of DDR SDRAM.=20

I know traditionally, SDRAM starts at '0', and I believe that=20
Linux is expecting some of the physical memory at this a low=20
memory location?

So, I am in a dilemma - I don't want to waste some DDR RAM by=20
also overlapping internal MPC8548 configuration registers=20
that are located near the top of the lowest 4 GIG memory area...

So Can I:

 1) Split the definition for the DDR Local Access Windows into 2 pieces
     a) 2 GIG (starting at 0x0)=20
     b) 2 Gig above (starting at 0x1_0000_0000)?

                   Or

2) Configure the LAW/MMU in a fashion before I load/boot Linux
    to use DDR at (a Local Access Window of) 0x1_0000_0000?

Thank you for your patience and suggestions on this subject.

Tom Morrison
Principal Software Engineer


EMPIRIX=20
20 Crosby Drive - Bedford, MA  01730
p: 781.266.3567 f: 781.266.3670=20
email: tmorrison@empirix.com=20
www.empirix.com
