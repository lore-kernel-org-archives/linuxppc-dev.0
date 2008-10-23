Return-Path: <niklaus.giger@member.fsf.org>
Received: from viefep28-int.chello.at (viefep28-int.chello.at [62.179.121.48])
	by ozlabs.org (Postfix) with ESMTP id 387CEDDE2A
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 09:00:46 +1100 (EST)
Received: from ng.localnet ([77.56.223.114]) by viefep28-int.chello.at
	(InterMail vM.7.08.02.02 201-2186-121-104-20070414) with ESMTP
	id <20081023220044.NLWZ17208.viefep28-int.chello.at@ng.localnet>
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 00:00:44 +0200
From: Niklaus Giger <niklaus.giger@member.fsf.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: adding more machines to snd-aoa
Date: Fri, 24 Oct 2008 00:00:40 +0200
References: <1224769461.6002.12.camel@johannes.berg>
In-Reply-To: <1224769461.6002.12.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200810240000.41602.niklaus.giger@member.fsf.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Am Donnerstag 23 Oktober 2008 15.44:21 schrieb Johannes Berg:
Hi Johannes

My wife has a PowerBook with exactly the machine you are looking for.
(Running Linux pb 2.6.24-19-powerpc #1 Fri Jul 11 21:37:37 UTC 2008 ppc 
GNU/Linux)

Therefore here the following info.

cat /proc/cpuinfo
processor       : 0
cpu             : 7447/7457, altivec supported
clock           : 999.999000MHz
revision        : 0.1 (pvr 8002 0101)
bogomips        : 60.02
timebase        : 18432000
platform        : PowerMac
machine         : PowerBook5,2
motherboard     : PowerBook5,2 MacRISC3 Power Macintosh
detected as     : 287 (PowerBook G4 15")
pmac flags      : 0000001b
L2 cache        : 512K unified
pmac-generation : NewWorld
/proc/device-tree/pci@f2000000/mac-io@17/i2s@10000/i2s-a@10000/sound/device-id
 find /proc/device-tree/ -wholename '*sound/device-id' | xargs hd
00000000  00 00 00 23                                       |...#|
00000004

If you want the whole device tree, just tell me how to dump it and I will send 
it to you.

Best regards

Niklaus
> Hi,
>
> Andreas (Cc'ed) asked whether it was possible to use snd-aoa on his
> machine, a PowerMac3,6. It appears that it is fairly easy since the
> machine seems to use a regular i2sbus.
>
> To identify it, after looking through my device-tree collections I think
> that the "device-id" property of the sound node would be the best bet.
> This is the value "22" for a PowerMac3,6.
>
> However, this node is also present on at least a PowerBook5,2 (value
> 35). Can somebody who has such a machine please reply to this me?
> Sjoerd, I think you have/had such a machine? I'd like you to test a few
> patches once they're ready, and I need to know what connectors it has
> (line-in, mic, headphones, ...).
>
> However, even if that works, I'll also need to know whether there are
> any other machines that have such a device-id property so that making
> snd-aoa-i2sbus aware of machines with device-id doesn't break those that
> I don't list. Therefore, if you have access to a machine that is
> newworld and has audio, please run the following commands:
>
> find /proc/device-tree/ -wholename '*sound/device-id'
> find /proc/device-tree/ -wholename '*sound/device-id' | xargs hd
>
> and let me know their output. No output is fine, I'm only interested in
> those machines that have this property. If you have access to a DT
> collection (hi Ben :) ) I'd appreciate if you could run it on that.
>
> johannes

-- 
NIklaus Giger
