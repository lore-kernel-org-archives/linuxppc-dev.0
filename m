Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 9369A1A30E6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 21:37:22 +1000 (AEST)
Message-ID: <555B206F.2030905@c-s.fr>
Date: Tue, 19 May 2015 13:37:19 +0200
From: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>,
 Scott Wood <scottwood@freescale.com>
Subject: Re: [v2,2/2] powerpc32: add support for csum_add()
References: <20150203113927.8604D1A5F14@localhost.localdomain>
 <20150325013023.GA7588@home.buserror.net> <553FD904.8000309@c-s.fr>
 <1430528414.16357.201.camel@freescale.com>
 <20150504221055.GA17056@gate.crashing.org>
In-Reply-To: <20150504221055.GA17056@gate.crashing.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 05/05/2015 00:10, Segher Boessenkool a écrit :
> On Fri, May 01, 2015 at 08:00:14PM -0500, Scott Wood wrote:
>> On Tue, 2015-04-28 at 21:01 +0200, christophe leroy wrote:
>>> The generated code is most likely different on ppc64. I have no ppc64
>>> compiler
> For reference: yes you do.  Just add -m64.
[root@localhost knl]# LANG= ppc-linux-gcc -m64 test.c
test.c:1:0: error: -m64 not supported in this configuration

Christophe
