Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 7B65DDDF59
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 09:17:01 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 08/10] cell: add support for proper device-tree
Date: Tue, 24 Apr 2007 01:16:57 +0200
References: <20070423193538.576702568@arndb.de>
	<20070423193913.253050755@arndb.de>
In-Reply-To: <20070423193913.253050755@arndb.de>
MIME-Version: 1.0
Message-Id: <200704240116.58364.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: Christian Krafft <krafft@de.ibm.com>, paulus@samba.org,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 23 April 2007, Arnd Bergmann wrote:
> From: Christian Krafft <krafft@de.ibm.com>
> 
> This patch adds support for a proper device-tree.
> A porper device-tree on cell contains be nodes
> for each CBE containg nodes for SPEs and all the
> other special devices on it.
> Ofcourse oldschool devicetree is still supported.
> 
> Signed-off-by: Christian Krafft <krafft@de.ibm.com>
> Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Christian, I only now saw that there is this rather important
patch left, it never stood out as something for 2.6.21 and now
it's too late for that.
This might explain why people could not boot some hardware
with Fedora 7.

Should we try to get this in as a hotfix?

	Arnd <><
