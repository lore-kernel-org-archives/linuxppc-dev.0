Return-Path: <tmorrison@empirix.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: MPC8548 PCI Express Support
Date: Thu, 28 Dec 2006 15:04:20 -0500
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D90105CF46AB@EMPBEDEX.empirix.com>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: <linuxppc-embedded@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I am a newbie to this list. I have tried to search the=20
list's archives to see if this has been discussed=20
for ideas, and I do not see anything related to this.

I am working on a MPC8548 platform, which has a=20
PLX 8532 PCI-Express chip on it.=20

I am using a 2.6.18.x linux kernel (x=3D6 at the moment)

I saw there are patches for linux kernel for 2.6.11.x=20
(via freescale), but I am hoping you guys know of something
a little 'newer' than that (so I can patch a 2.6.18.6 kernel)

Also,l PLX supplies a linux driver, but it is module driven.=20
I could put the module and associated 'loader' into the InitRD image=20
(and load it up), but it would be 'neater' to have the support
built-in to the kernel. Would you guys have any suggestions=20
and/or experience with this?

Any/all suggestions and experiences shared are more than welcomed.=20

All the best~!

Tom Morrison
tmorrison@empirix.com=20
