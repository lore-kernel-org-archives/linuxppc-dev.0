Return-Path: <pku.leo@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.239])
	by ozlabs.org (Postfix) with ESMTP id 498C6DDDB6
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 20:16:13 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f9so324325rvb.9
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 03:16:11 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
Date: Tue, 28 Apr 2009 18:16:11 +0800
Message-ID: <2a27d3730904280316l7049bddbie914907b16ccfff6@mail.gmail.com>
Subject: [PATCH 0/5] rapidio: adding memory mapping IO support and misc fixes
From: Li Yang <leoli@freescale.com>
To: akpm@linux-foundation.org, Kumar Gala <galak@kernel.crashing.org>,
	David Miller <davem@davemloft.net>, mporter@kernel.crashing.org
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	linux-kernel@vger.kernel.org, Netdev <netdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The patch series add MMIO support to Linux rapidio and fix a few nits.
 The patches cross rapidio, netdev, powerpc sub-systems.  It will be
good for them to go through one tree.  Probably Andrew?  As the
previous rapidio patches are mostly merged by you.

- Leo
