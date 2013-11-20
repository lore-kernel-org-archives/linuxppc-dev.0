Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by ozlabs.org (Postfix) with ESMTP id 4609D2C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2013 20:37:23 +1100 (EST)
Message-ID: <528C82D1.4090803@c-s.fr>
Date: Wed, 20 Nov 2013 10:37:21 +0100
From: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: BUG: Patch "Convert some mftb/mftbu into mfspr" breaks MPC885
Content-Type: multipart/alternative;
 boundary="------------040601090207020000060607"
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040601090207020000060607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Scott,

The patch "Convert some mftb/mftbu into mfspr" 
(beb2dc0a7a84be003ce54e98b95d65cc66e6e536 
<https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/arch/powerpc/include/asm/reg.h?id=beb2dc0a7a84be003ce54e98b95d65cc66e6e536>) 
breaks startup on MPC885.

The CPU traps (SoftwareEmulation trap) at sched_clock() when trying to 
read TBU with mfspr.

Reverting the patch solves the issue.

What's the prefered way to fix this ?

Christophe

--------------040601090207020000060607
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    Scott,<br>
    <br>
    The patch "Convert some mftb/mftbu into mfspr" (<a
href="https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/arch/powerpc/include/asm/reg.h?id=beb2dc0a7a84be003ce54e98b95d65cc66e6e536"
      style="color: blue; text-decoration: none; font-family: monospace;
      font-size: 12px; font-style: normal; font-variant: normal;
      font-weight: normal; letter-spacing: normal; line-height: normal;
      orphans: auto; text-align: start; text-indent: 0px;
      text-transform: none; white-space: normal; widows: auto;
      word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(255, 255, 255);">beb2dc0a7a84be003ce54e98b95d65cc66e6e536</a>)
    breaks startup on MPC885.<br>
    <br>
    The CPU traps (SoftwareEmulation trap) at sched_clock() when trying
    to read TBU with mfspr.<br>
    <br>
    Reverting the patch solves the issue.<br>
    <br>
    What's the prefered way to fix this ?<br>
    <br>
    Christophe<br>
  </body>
</html>

--------------040601090207020000060607--
