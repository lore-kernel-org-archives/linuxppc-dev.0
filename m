Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18068.5095.617248.850084@cargo.ozlabs.ibm.com>
Date: Wed, 11 Jul 2007 09:19:03 +1000
From: Paul Mackerras <paulus@samba.org>
To: Manish Ahuja <ahuja@austin.ibm.com>
Subject: Re: [PATCH] Infinite loop/always true check possible with unsigned
	counter.
In-Reply-To: <4693D27D.7070504@austin.ibm.com>
References: <469270F3.4070206@austin.ibm.com> <46928691.2040008@austin.ibm.com>
	<18066.53384.449544.952545@cargo.ozlabs.ibm.com>
	<je1wfgh9qj.fsf@sykes.suse.de>
	<18067.22066.466767.663198@cargo.ozlabs.ibm.com>
	<jewsx8fuqk.fsf@sykes.suse.de>
	<18067.23198.856592.39397@cargo.ozlabs.ibm.com>
	<4693D27D.7070504@austin.ibm.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Manish Ahuja writes:

> I presume the patch is good then. Do I need to change anything ?

I guess not.  It will cause a warning on the first for loop if anyone
tries to compile with -Wextra or -Wsign-compare, but it would be only
one of lots of warnings in that case (and in fact comparing signed
with unsigned is a perfectly legitimate, well-defined thing to do; you
just have to be aware that the comparison is done as unsigned).

Paul.
