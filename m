Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0307667C4D
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 19:30:37 +1100 (EST)
In-Reply-To: <11654526463043-git-send-email-ntl@pobox.com>
References: <11654526463043-git-send-email-ntl@pobox.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <38E12654-EED6-4335-9DC6-293FE70A797C@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4] maple: match "pcie" name for CPC945
Date: Thu, 7 Dec 2006 09:30:29 +0100
To: Nathan Lynch <ntl@pobox.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Some firmwares have "pcie" for the "name" property of the CPC945 PCI
> Express host bridge.  Check for "pcie" in addition to "pci" so we
> don't miss it.

You shouldn't use "name" but "device_type" and "compatible".


Segher
