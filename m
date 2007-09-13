Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id E6ABCDDDE9
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 14:39:04 +1000 (EST)
Date: Wed, 12 Sep 2007 23:40:11 -0500
From: Olof Johansson <olof@lixom.net>
To: lakshminarayana babu <babu.pci81@gmail.com>
Subject: Re: Linuxppc-dev Digest, Vol 37, Issue 84
Message-ID: <20070913044011.GA7706@lixom.net>
References: <mailman.2011.1189652741.2970.linuxppc-dev@ozlabs.org>
	<a38e30640709122131g14642e9pa599681551ed9c23@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a38e30640709122131g14642e9pa599681551ed9c23@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 13, 2007 at 10:01:36AM +0530, lakshminarayana babu wrote:
> i am new to the linux.....can you tell me how to access the pci
> configuration space using ioremap function...but  it is implicit function
> declaration...

That is architecture and platform dependent. Some platforms don't even
have a memory-mappable interface to configuration space.

Instead, please use the abstracted config access functions that the
kernel provides. (pci_read_config_word and friends).


-Olof
