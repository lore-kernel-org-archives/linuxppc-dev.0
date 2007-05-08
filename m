Return-Path: <vitb@kernel.crashing.org>
Received: from localhost.localdomain (unknown [85.94.3.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DCF58DDE26
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 19:51:08 +1000 (EST)
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: linux-pcmcia@lists.infradead.org
Subject: [PATCH 0/3] 8xx PCMCIA stuff && cleanup: take 3
Date: Tue, 08 May 2007 13:50:32 +0400
Message-ID: <20070508095001.20018.85403.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sorry for such amount of noise, have to resubmit to catch up
with Olof's notes, and to kill empty ranges property in dts since
it is not appropriate before driver could handle it.

Thanks all for attention.
-- 
Sincerely, Vitaly
