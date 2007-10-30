Return-Path: <jdi@l4x.org>
Received: from rzcomm22.rz.tu-bs.de (rzcomm22.rz.tu-bs.de [134.169.9.68])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E8692DE117
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 18:35:22 +1100 (EST)
Message-ID: <4726DD82.8050200@l4x.org>
Date: Tue, 30 Oct 2007 08:30:10 +0100
From: Jan Dittmer <jdi@l4x.org>
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>
Subject: Re: boot/wrap assumes a biarch toolchain?
References: <20071029140719.GA17120@kryten>
	<jesl3udm0e.fsf@sykes.suse.de>	<4725F34C.6090904@ppp0.net>
	<jelk9mdj6e.fsf@sykes.suse.de>	<47263830.2010009@l4x.org>
	<jebqahei70.fsf@sykes.suse.de>	<47265586.1050701@l4x.org>
	<je640pebqn.fsf@sykes.suse.de>
In-Reply-To: <je640pebqn.fsf@sykes.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andreas Schwab wrote:
> Jan Dittmer <jdi@l4x.org> writes:
> 
>> Same error, you write above that a newer compiler version should
>> not need -m32 or --with-cpu=default32 any more?
> 
> ??? Where did I say that?

Your mail from 2007-10-29 4:39 pm (CET)

 >> Your compiler still needs -m32 to generate 32-bit code (or use
 >> --with-cpu=default32 to make that the default).

See the 'still' ? I just assumed that it must have been changed
in newer versions.

But to sum up. I've to compile with '--with-cpu=default32' and all
should be fine? Because I have no idea how to pass the -m32 flag
just to the 32-bit code generation. Passing it via CFLAGS obviously
does not work as it also passes it to the 64 bit code generation.

Jan
