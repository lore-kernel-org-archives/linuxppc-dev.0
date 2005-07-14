Return-Path: <frankvm@frankvm.com>
Received: from janus.localdomain (frankvm.xs4all.nl [80.126.170.174])
	by ozlabs.org (Postfix) with ESMTP id BDF0767C80
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jul 2005 22:52:34 +1000 (EST)
Date: Thu, 14 Jul 2005 14:52:32 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <20050714125232.GA13456@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Using lswi/stswi inside the kernel
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Are there any issues I should be aware of?

I think most SAVE_GPR* and REST_GPR* macros could be replaced by a
single lswi/stswi instruction.

-- 
Frank
