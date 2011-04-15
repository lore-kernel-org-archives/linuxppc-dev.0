Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 44E6BB6FB7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Apr 2011 16:52:08 +1000 (EST)
Message-ID: <4DA7E697.1050406@ovro.caltech.edu>
Date: Thu, 14 Apr 2011 23:32:55 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: koteswararaom@vrindatech.com
Subject: Re: PCI Memory mapping
References: <000001c19230$70546870$50fd3950$@com>
In-Reply-To: <000001c19230$70546870$50fd3950$@com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ajith,

> I have come across this forum, and I have a question. I am working on
> PCI device driver, I am trying to insert the pci card in to the pci slot
> of the main computer, I am finding a problem here, when I insert the
> card in to the pci slot, my pci device ID and vendor Id are not getting
> displayed. I am using windows xp o/s.
>
> I am trying to map pci memory. Can you suggest me how can we map the pci
> memory. What steps should I take in order to make my Device Id and
> Vendor Id displayed when I insert the card in to the pci slot.

This is a PowerPC Linux developer list so your question is
way off-topic here.

If your PCI card is not showing up at all, it could be due to the
fact that it is not being powered. I have found old motherboards
that do not supply both the 5V and 3.3V rails to PCI slots.
Check the power supplies on your PCI board, or at least
measure the PCI power pins in the slots. Then if power is present,
check there is a PCI clock in the slot. After that, boot Linux
from a bootable CD-ROM and type lspci to see if your device is
listed.

Cheers,
Dave
