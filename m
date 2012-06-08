Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 55EC9B6FC5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2012 17:34:42 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc: Optimise the 64bit optimised __clear_user
References: <20120604175858.38dac554@kryten> <20120605120222.6722a3e3@kryten>
 <178E3BC0-C6E2-4E33-BA66-8144F192A151@kernel.crashing.org>
 <20120607030423.GA30053@drongo> <4FD0EA08.7040903@freescale.com>
Date: Fri, 08 Jun 2012 09:34:33 +0200
In-Reply-To: <4FD0EA08.7040903@freescale.com> (Scott Wood's message of "Thu, 7
 Jun 2012 12:51:04 -0500")
Message-ID: <m2bokuuuie.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: mikey@neuling.org, michael@ellerman.id.au,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 olof@lixom.net, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> writes:

> and that objdump decodes it as "dcbz r0,r3" rather than "dcbz 0,r3".

<http://permalink.gmane.org/gmane.comp.gnu.binutils/57870>

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
