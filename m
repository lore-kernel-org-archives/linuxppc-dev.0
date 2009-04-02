Return-Path: <akinobu.mita@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.238])
	by ozlabs.org (Postfix) with ESMTP id C7272DDD01
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Apr 2009 18:02:08 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id g9so400100rvb.9
	for <linuxppc-dev@ozlabs.org>; Thu, 02 Apr 2009 00:02:07 -0700 (PDT)
Date: Thu, 2 Apr 2009 16:02:00 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] Fix highmem build failure
Message-ID: <20090402070200.GB3951@localhost.localdomain>
References: <1238647129-27417-1-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1238647129-27417-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Looks good. I tested it on x86_32.
