Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 5/5] powerpc: Dynamically calculate the dabrx based on
 kernel/user/hypervisor
In-reply-to: <1346908671-7464-5-git-send-email-mikey@neuling.org>
References: <1346908671-7464-1-git-send-email-mikey@neuling.org>
 <1346908671-7464-5-git-send-email-mikey@neuling.org>
Date: Thu, 06 Sep 2012 15:31:52 +1000
Message-ID: <8706.1346909512@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> wrote:

> Currently we mark the DABRX to interrupt on all matches
> (hypervisor/kernel/user and then filter in software.  We can be a lot
> smarter now that we can set the DABRX dynamically.
> 
> This sets the DABRX based on the flags passed by the user.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>


For what it's worth, I have this test case now:

  http://neuling.org/devel/junkcode/hw_brk_test.c

Mikey
