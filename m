Return-Path: <thomas.moll@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [195.145.229.155])
	by ozlabs.org (Postfix) with ESMTP id 694A3B7D9E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 May 2010 16:39:21 +1000 (EST)
Date: Tue, 18 May 2010 08:28:16 +0200
From: Thomas Moll <thomas.moll@sysgo.com>
To: akpm@linux-foundation.org
Subject: [PATCH 0/1] RapidIO: Fix maintenance access to higher memory areas
Message-Id: <20100518082816.900554d5.thomas.moll@sysgo.com>
In-Reply-To: <1272901558-9292-1-git-send-email-alexandre.bounine@idt.com>
References: <1272901558-9292-1-git-send-email-alexandre.bounine@idt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, alexandre.bounine@idt.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following RapidIO patch is applicable to the latest kernel tree with applied RapidIO patches from Alexandre Bounine. The modification is required for IDT CPS switch devices which will access these memory areas, to setup 16bit routing.
