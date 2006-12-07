Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 3A3F467C2C
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 14:23:48 +1100 (EST)
Date: Wed, 6 Dec 2006 21:20:51 -0600
From: Olof Johansson <olof@lixom.net>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH 1/4] maple: match "pcie" name for CPC945
Message-ID: <20061206212051.756e0634@localhost.localdomain>
In-Reply-To: <11654526463043-git-send-email-ntl@pobox.com>
References: <11654526463043-git-send-email-ntl@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed,  6 Dec 2006 18:50:43 -0600 Nathan Lynch <ntl@pobox.com> wrote:

> Some firmwares have "pcie" for the "name" property of the CPC945 PCI
> Express host bridge.  Check for "pcie" in addition to "pci" so we
> don't miss it.

1275 (draft) supplement for PCI Express use 'pciex'. 'Some firmware'
should be changed instead, if possible.

See http://playground.sun.com/1275/bindings/pci/pci-express.txt

That's also what pseries and rtas_pci uses.


-Olof
