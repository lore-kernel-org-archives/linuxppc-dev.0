Return-Path: <super.firetwister@googlemail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.189])
	by ozlabs.org (Postfix) with ESMTP id AF529DDF66
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 16:09:14 +1000 (EST)
Received: by mu-out-0910.google.com with SMTP id w1so233427mue.9
	for <linuxppc-dev@ozlabs.org>; Thu, 04 Sep 2008 23:09:11 -0700 (PDT)
To: Ben Nizette <bn@niasdigital.com>
Subject: Re: UIO not working on ppc405 onchip registers
Date: Fri, 5 Sep 2008 08:18:58 +0200
References: <200807212152.16080.super.firetwister@gmail.com>
	<200807220948.51053.super.firetwister@gmail.com>
	<1216713170.4004.243.camel@moss.renham>
In-Reply-To: <1216713170.4004.243.camel@moss.renham>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809050818.59425.super.firetwister@gmail.com>
From: Markus Brunner <super.firetwister@googlemail.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 22 July 2008, Ben Nizette wrote:

> But I'll let you get back to solving the UIO problem at hand :-D

I already surrendered and created (hacked) a read/write driver, which let me 
use the old userspace drivers I'm trying to port (with some changes of 
course). This was way faster than understanding all the involved APIs and 
creating glue code between them. And the amount of time it needs was easy to 
estimate.

However accidently I ran over the "old school" userland mmap code 
with /dev/mem. I already knew mapping with /dev/mem is possible but I haven't 
thought this could make a difference.

http://ozlabs.org/pipermail/linuxppc-embedded/2006-August/023811.html

Also I was wrong with my assumption that uio worked well on the peripherals. 
It worked (very) well on the leds, just to fool me!!! But it returned crap on 
some version registers.

With a working and a non working version of mmap it should be rather easy to 
trace this bug. Unfortunately I was already short of time before running into 
this (and other) problems and it didn't get any better. 
So I would need some help from someone with more experience to fix this. 
Any instructions?

Markus
