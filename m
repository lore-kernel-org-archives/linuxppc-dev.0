Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sd2Sy4yF2zDsd9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 20:39:46 +1000 (AEST)
Message-ID: <1474281536.2857.15.camel@kernel.crashing.org>
Subject: Re: PowerPC agpmode issues
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Herminio Hernandez, Jr." <herminio.hernandezjr@gmail.com>, Mike
 <michael.heltne@gmail.com>
Cc: Pranith Kumar <bobby.prani@gmail.com>, "open list:LINUX FOR POWERPC..."
 <linuxppc-dev@lists.ozlabs.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, "debian-powerpc@lists.debian.org"
 <debian-powerpc@lists.debian.org>
Date: Mon, 19 Sep 2016 20:38:56 +1000
In-Reply-To: <CAJRA9dwyJ+5XuD7i0ktwvx3Md9p_Z9tiVZCWvO_gK1kfG-+ccA@mail.gmail.com>
References: <CANtoAtPSgkxEvAdOs-gZGOECYN8OFTvwRrsg+US41ji1fGEDLA@mail.gmail.com>
 <969BB53B-CB30-49DC-B6C5-4D2381ECE6EE@gmail.com>
 <CANtoAtN1K3OAoXsgeMOWui_jEZO3X1fJAmRX-LeO_Du8h3T9kg@mail.gmail.com>
 <1472122446.2246.93.camel@kernel.crashing.org> <57DF23C4.20508@gmail.com>
 <CAJRA9dwyJ+5XuD7i0ktwvx3Md9p_Z9tiVZCWvO_gK1kfG-+ccA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-09-19 at 02:13 -0700, Herminio Hernandez, Jr. wrote:
> 
> I noticed the GPU was set to PCI mode however I did not set
> radeon.agpmode=-1 in yaboot. I then installed Lubuntu 16.10 along
> side Debian. I noticed that GPU was working and it was not set to
> force PCI mode. Has there been a change to kernel in Debian to force
> this by default? If so it looks like it is breaking on certain G5
> machines. I am attaching bothe dmesg files for review.
> 
> Thanks and sorry for the previous garbled email.

Hrm... this is odd. I would expect PCI mode to work and AGP to be
busted to be honest. Can you provide the complete log ? I wonder
if it's trying to enable the PCIe bypass high aperture and hits the
Radeon address limit...

Ben.
