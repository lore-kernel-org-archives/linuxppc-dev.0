Return-Path: <sergey.senozhatsky@gmail.com>
Received: from mail-pf0-x229.google.com (mail-pf0-x229.google.com
 [IPv6:2607:f8b0:400e:c00::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCqjS0gS9zDvMs
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2016 00:22:20 +1100 (AEDT)
Received: by mail-pf0-x229.google.com with SMTP id d2so108452270pfd.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Nov 2016 05:22:20 -0800 (PST)
Date: Tue, 8 Nov 2016 22:21:07 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Paul Burton <paul.burton@imgtec.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Andreas Schwab <schwab@linux-m68k.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Borislav Petkov <bp@suse.de>, Petr Mladek <pmladek@suse.com>,
 Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Larry Finger <Larry.Finger@lwfinger.net>
Subject: revert 05fd007e46296afb (was: [PATCH v3] console: use first console
 if stdout-path device doesn't appear)
Message-ID: <20161108132107.GA384@swordfish>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <190a8a8f-228c-6992-393f-70afb3523810@lwfinger.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Andrew,


(just in case)

please revert 'commit 05fd007e46296afb24 ("console: don't prefer first
registered if DT specifies stdout-path")'

	-ss
