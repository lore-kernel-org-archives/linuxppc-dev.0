Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by lists.ozlabs.org (Postfix) with ESMTP id 3sdSXb4PT0zDsgG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 13:14:23 +1000 (AEST)
Subject: Re: PowerPC agpmode issues
To: Mathieu Malaterre <malat@debian.org>,
 "Herminio Hernandez, Jr." <herminio.hernandezjr@gmail.com>
References: <CANtoAtPSgkxEvAdOs-gZGOECYN8OFTvwRrsg+US41ji1fGEDLA@mail.gmail.com>
 <969BB53B-CB30-49DC-B6C5-4D2381ECE6EE@gmail.com>
 <CANtoAtN1K3OAoXsgeMOWui_jEZO3X1fJAmRX-LeO_Du8h3T9kg@mail.gmail.com>
 <1472122446.2246.93.camel@kernel.crashing.org> <57DF23C4.20508@gmail.com>
 <CAJRA9dwyJ+5XuD7i0ktwvx3Md9p_Z9tiVZCWvO_gK1kfG-+ccA@mail.gmail.com>
 <CA+7wUsyOSCJzymLe7vyub8dvyvsEDuVU0auO2rGi6ohkBKBEoQ@mail.gmail.com>
Cc: Mike <michael.heltne@gmail.com>,
 "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Pranith Kumar <bobby.prani@gmail.com>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <28807f61-b73e-b695-ea6a-cb51c1554144@daenzer.net>
Date: Tue, 20 Sep 2016 12:05:17 +0900
MIME-Version: 1.0
In-Reply-To: <CA+7wUsyOSCJzymLe7vyub8dvyvsEDuVU0auO2rGi6ohkBKBEoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19/09/16 09:36 PM, Mathieu Malaterre wrote:
> 
> Finally your dmesg looks odd since the line `[drm] Forcing AGP to PCI
> mode` comes only after the first error.

That isn't odd but the AGP->PCI(e) fallback mechanism working as
intended, trying AGP first and falling back to PCIe if AGP fails.

Herminio, does the problem also occur if you specify radeon.agpmode=-1
(or maybe =1) on the kernel command line?


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
