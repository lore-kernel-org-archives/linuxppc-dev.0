Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18116.52843.212978.281399@cargo.ozlabs.ibm.com>
Date: Fri, 17 Aug 2007 08:23:39 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: 2.6.23-rc3 broken on G5
In-Reply-To: <jelkccftt6.fsf@sykes.suse.de>
References: <jelkccftt6.fsf@sykes.suse.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andreas Schwab writes:

> This change:
> 
> commit edd0622bd2e8f755c960827e15aa6908c3c5aa94
> Author: Paul Mackerras <paulus@samba.org>
> Date:   Fri Aug 10 21:04:07 2007 +1000
> 
>     [POWERPC] Fix potential duplicate entry in SLB shadow buffer
> 
> is broken on PowerMac G5.  It crashes very early, before the bootx
> console is set up.

Hmmm.  It (current Linus git) works fine on my dual 2.0GHz G5.

What sort of G5 do you have and what is your .config?

Paul.
