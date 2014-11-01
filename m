Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DED191A0024
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Nov 2014 00:33:38 +1100 (AEDT)
Date: Sat, 1 Nov 2014 08:33:17 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: Replace cc constraint in inline assembly with cr0
Message-ID: <20141101133317.GA1608@gate.crashing.org>
References: <1414802571-20225-1-git-send-email-anton@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1414802571-20225-1-git-send-email-anton@samba.org>
Cc: ulrich.weigand@de.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Nov 01, 2014 at 11:42:51AM +1100, Anton Blanchard wrote:
> Our inline assembly only clobbers the first condition register field,
> but we mark all of them as being clobbered.

No, we don't.  "cc" has been an alias for cr0 for over twenty two and a
half years now; it has never changed meaning.  This is an LLVM bug.


Segher
