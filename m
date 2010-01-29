Return-Path: <linasvepstas@gmail.com>
Received: from mail-yx0-f185.google.com (mail-yx0-f185.google.com
	[209.85.210.185]) by ozlabs.org (Postfix) with ESMTP id EDBA0B7D1C
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Jan 2010 02:42:06 +1100 (EST)
Received: by yxe15 with SMTP id 15so1924160yxe.9
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jan 2010 07:42:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1264723487.20211.17.camel@pasglop>
References: <0642ead63df1b9fdced24750eb0aea940f0408b7.1264617281.git.root@sanx1002.austin.ibm.com>
	<930155d7427ae670cd2add220649c6490f68d0d4.1264617281.git.root@sanx1002.austin.ibm.com>
	<1264723487.20211.17.camel@pasglop>
Date: Fri, 29 Jan 2010 09:42:04 -0600
Message-ID: <3ae3aa421001290742i7768cb79gf0684758dbe85a0d@mail.gmail.com>
Subject: Re: [PATCH 2/2] eeh: fixing pci_dev dependency
From: Linas Vepstas <linasvepstas@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, leitao@linux.vnet.ibm.com
Reply-To: linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28 January 2010 18:04, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2010-01-27 at 12:43 -0600, leitao@linux.vnet.ibm.com wrote:
>> Currently pci_dev can be null when EEH is in action. This patch
>> just assure that we pci_dev is not NULL before calling pci_dev_put.
>
> Like all variants of *_put(), it already checks for a NULL argument
> afaik. So that patch should be unnecessary.

Ah, OK, I paniced when I saw that and assumed the worst

--linas
