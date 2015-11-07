Return-Path: <laurent@vivier.eu>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 96C531A0CFB
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Nov 2015 22:33:10 +1100 (AEDT)
Subject: Re: [PATCH] powerpc: allow cross-compilation of ppc64 kernel
To: Segher Boessenkool <segher@kernel.crashing.org>,
 Scott Wood <scottwood@freescale.com>
References: <1446724029-10884-1-git-send-email-laurent@vivier.eu>
 <1446844180.11597.13.camel@freescale.com>
 <20151106225549.GA21395@gate.crashing.org>
 <20151106233235.GA24762@gate.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 linux-kernel@vger.kernel.org
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <563DE160.505@vivier.eu>
Date: Sat, 7 Nov 2015 12:32:48 +0100
MIME-Version: 1.0
In-Reply-To: <20151106233235.GA24762@gate.crashing.org>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 07/11/2015 00:32, Segher Boessenkool a écrit :
> On Fri, Nov 06, 2015 at 04:55:49PM -0600, Segher Boessenkool wrote:
>> On Fri, Nov 06, 2015 at 03:09:40PM -0600, Scott Wood wrote:
>>> Why is GCC building ppc64 object files but telling the linker --oformat elf32-
>>> powerpcle?  Are different options somehow being passed to GCC in one case 
>>> versus the other?
>>
>> This was changed for GCC 6 in <http://gcc.gnu.org/r227397>, could one of
>> you check if that fixes this problem?  If so we'll need to backport it.
> 
> Actually it already has been backported, r228089.

Thank you, I'm going to see if it can be included in the distro I use.

Laurent
