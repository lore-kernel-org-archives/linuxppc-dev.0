Return-Path: <pku.leo@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 4D912DDF00
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 18:40:53 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so1817341ywt.39
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 01:40:52 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
Date: Tue, 12 May 2009 16:40:52 +0800
Message-ID: <2a27d3730905120140m21ca81d7t8206e657b02ffbfb@mail.gmail.com>
Subject: [PATCH 0/6] rapidio: adding memory mapping IO support and misc fixes
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

This is a re-post of patch series which adds MMIO support to Linux
RapidIO and fixes a few nits.

- Leo
