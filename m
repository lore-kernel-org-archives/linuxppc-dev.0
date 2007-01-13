Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17833.28593.835578.560151@cargo.ozlabs.ibm.com>
Date: Sun, 14 Jan 2007 10:48:01 +1100
From: Paul Mackerras <paulus@samba.org>
To: yuraxa <ygeorgie@gmail.com>
Subject: Re: ppc inline asm syntax
In-Reply-To: <7cc53cfa0701131028y42ed2b9age0fccf29c35fd708@mail.gmail.com>
References: <7cc53cfa0701130341x2dfdc8f1s9cb70ffa741fafb6@mail.gmail.com>
	<je64bb6p2j.fsf@sykes.suse.de>
	<7cc53cfa0701131028y42ed2b9age0fccf29c35fd708@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

yuraxa writes:

> Thanks a'lot, It helps! But may be you'll be so graceful to explain
> more precisely?
> I don't quite understand how the final string will look like...
> For 'U' operand modifier the comment is:
> /* Print `u' if this has an auto-increment or auto-decrement.  */
> But for 'X' operand modifier there is no comment at all.

'X' turns into "x" if gcc wants to use indexed addressing mode, or
nothing if gcc wants to use base + offset mode.

I agree that the gcc documentation of the details of inline assembly
for each specific architecture is woeful.  I have found it useful in
the past to get hold of the gcc source code and look in rs6000.md for
examples of what can be done.

Paul.
