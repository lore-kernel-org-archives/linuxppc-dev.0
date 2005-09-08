Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17183.48543.616634.628331@cargo.ozlabs.ibm.com>
Date: Thu, 8 Sep 2005 14:27:11 +1000
From: Paul Mackerras <paulus@samba.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <20050908005821.GB8882@dmt.cnet>
References: <20050907230324.GC7513@dmt.cnet> <1126139332.29803.0.camel@gaston>
	<00a1f47bb2edbbc001c2267191aa36f0@embeddededge.com>
	<20050908005821.GB8882@dmt.cnet>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] add big endian version of ld_/st_ IO access macros and
	convert main 8xx code to use it
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Marcelo Tosatti writes:

> eieio/isync are not required. There's no need to execute redudant
> instructions and occupy kernel space.

Given how long it takes to access I/O devices, I don't believe an
extra instruction or two is going to make a measurable difference.
Feel free to show me measurements proving me wrong, of course... :)

Paul.
