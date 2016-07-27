Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzsvD3L77zDqQD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 21:19:04 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: wei.guo.simon@gmail.com
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Shuah Khan <shuahkh@osg.samsung.com>,
 Anton Blanchard <anton@samba.org>, Cyril Bur <cyrilbur@gmail.com>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Ulrich Weigand <ulrich.weigand@de.ibm.com>,
 Michael Neuling <mikey@neuling.org>, Andrew Morton <akpm@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Rashmica Gupta <rashmicy@gmail.com>,
 Khem Raj <raj.khem@gmail.com>, Jessica Yu <jeyu@redhat.com>,
 Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Chris Smart <chris@distroguy.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v12 02/30] powerpc/process: Add the function
 flush_tmregs_to_thread
In-Reply-To: <1469611615-2935-3-git-send-email-wei.guo.simon@gmail.com>
References: <1469611615-2935-1-git-send-email-wei.guo.simon@gmail.com>
 <1469611615-2935-3-git-send-email-wei.guo.simon@gmail.com>
Date: Wed, 27 Jul 2016 21:19:00 +1000
Message-ID: <87oa5juy57.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Simon,

wei.guo.simon@gmail.com writes:
> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>
> This patch creates a function flush_tmregs_to_thread which
> will then be used by subsequent patches in this series. The
> function checks for self tracing ptrace interface attempts
> while in the TM context and logs appropriate warning message.
>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Shuah Khan <shuahkh@osg.samsung.com>
> Cc: Anton Blanchard <anton@samba.org>
> Cc: Cyril Bur <cyrilbur@gmail.com>
> Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Cc: Simon Guo <wei.guo.simon@gmail.com>
> Cc: Ulrich Weigand <ulrich.weigand@de.ibm.com>
> Cc: Michael Neuling <mikey@neuling.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Rashmica Gupta <rashmicy@gmail.com>
> Cc: Khem Raj <raj.khem@gmail.com>
> Cc: Jessica Yu <jeyu@redhat.com>
> Cc: Jiri Kosina <jkosina@suse.cz>
> Cc: Miroslav Benes <mbenes@suse.cz>
> Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Cc: Chris Smart <chris@distroguy.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org

Please drop these Cc lines from the change log.

> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---

This and all the other patches need your Signed-off-by, as well as
Anshuman's.

cheers
