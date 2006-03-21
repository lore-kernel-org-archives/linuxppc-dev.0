Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id BDAE767A77
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Mar 2006 05:45:56 +1100 (EST)
Date: Tue, 21 Mar 2006 12:43:58 -0600
To: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH 8/11] powerpc: Add strne2a() to convert a string from
	EBCDIC to ASCII
Message-ID: <20060321184358.GB5248@pb15.lixom.net>
References: <1142934351.193140.181086235013.qpush@concordia>
	<20060321094637.C86EE67BBB@ozlabs.org>
	<20060321181105.GA5248@pb15.lixom.net>
	<je64m7sl6g.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <je64m7sl6g.fsf@sykes.suse.de>
From: Olof Johansson <olof@lixom.net>
Cc: Michael Ellerman <michael@ellerman.id.au>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 21, 2006 at 07:32:39PM +0100, Andreas Schwab wrote:
> Olof Johansson <olof@lixom.net> writes:
> 
> > Why iterate over the string twice? Why not do 
> > 	for (..; i < n && src[n]; ...)
> 
> ITYM i < n && src[i].

Doh, right.


-Olof
