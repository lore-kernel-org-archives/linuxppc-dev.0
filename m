Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 517461A00C8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Nov 2014 07:17:22 +1100 (AEDT)
Date: Mon, 3 Nov 2014 07:17:19 +1100
From: Anton Blanchard <anton@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Replace cc constraint in inline assembly with cr0
Message-ID: <20141103071719.6f50de76@kryten>
In-Reply-To: <20141101133317.GA1608@gate.crashing.org>
References: <1414802571-20225-1-git-send-email-anton@samba.org>
 <20141101133317.GA1608@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ulrich.weigand@de.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Segher,

> > Our inline assembly only clobbers the first condition register
> > field, but we mark all of them as being clobbered.
> 
> No, we don't.  "cc" has been an alias for cr0 for over twenty two and
> a half years now; it has never changed meaning.  This is an LLVM bug.

Thanks! I opened http://llvm.org/bugs/show_bug.cgi?id=21451 to track it.

Anton
