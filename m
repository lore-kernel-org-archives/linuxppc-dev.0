Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18381.49853.255430.142431@cargo.ozlabs.ibm.com>
Date: Wed, 5 Mar 2008 08:44:29 +1100
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: V4L2: __ucmpdi2 undefined on ppc
In-Reply-To: <15d7ac5a7542b05fb9b9abb5d4c7a22d@kernel.crashing.org>
References: <Pine.SOC.4.61.0612131359430.10721@math.ut.ee>
	<1166053317.909.19.camel@praia>
	<20061214195842.GA14041@athena.road.mcmartin.ca>
	<1166362145.6714.53.camel@pmac.infradead.org>
	<6a89f9d50802060639j4b3a8b7u4e4e596b010ee353@mail.gmail.com>
	<15d7ac5a7542b05fb9b9abb5d4c7a22d@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, henrik.sorensen@gmail.com,
	Stephane Marchesin <marchesin@icps.u-strasbg.fr>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool writes:

> Every occurrence of r7 here is wrong (and some of the r6).  Is there
> any reason to do this in assembler code at all?

The fact that the obvious C code generates ... a call to __ucmpdi2? :)

Paul.
