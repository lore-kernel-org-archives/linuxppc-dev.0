Return-Path: <micha@neli.hopto.org>
Received: from edu-smtp-02.edutel.nl (edu-smtp-02.edutel.nl [88.159.1.222])
	by ozlabs.org (Postfix) with ESMTP id 1E043B7BAE
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 31 Oct 2009 02:48:15 +1100 (EST)
Message-ID: <4AEB0ABB.8070605@neli.hopto.org>
Date: Fri, 30 Oct 2009 16:48:11 +0100
From: Micha Nelissen <micha@neli.hopto.org>
MIME-Version: 1.0
To: Michael Buesch <mb@bu3sch.de>
Subject: Re: Accessing flash directly from User Space [SOLVED]
References: <BB99A6BA28709744BF22A68E6D7EB51F0330E23124@midas.usurf.usu.edu>	<200910301556.11349.mb@bu3sch.de>	<20091030150855.GA15046@mail.gnudd.com>
	<200910301624.03989.mb@bu3sch.de>
In-Reply-To: <200910301624.03989.mb@bu3sch.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: scottwood@freescale.com, Alessandro Rubini <rubini@gnudd.com>,
	bgat@billgatliff.com, linuxppc-dev@lists.ozlabs.org,
	Jonathan.Haws@sdl.usu.edu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Buesch wrote:
> Yes, I think the barrier is wrong.
> Please try with
> 
> #define mb()	__asm__ __volatile__("eieio\n sync\n" : : : "memory")


For uncached memory, eieio should be enough.

Micha
