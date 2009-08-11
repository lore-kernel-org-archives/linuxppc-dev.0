Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 10A35B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 Aug 2009 09:00:41 +1000 (EST)
Date: Tue, 11 Aug 2009 19:00:32 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Paul Gortmaker <paul.gortmaker@gmail.com>
Subject: Re: cross compiling wind river linux for ppc architecture
Message-ID: <20090811230032.GA31596@zod.rchland.ibm.com>
References: <70ca52c20908110709m41b1535ep4c8ed900163f3b18@mail.gmail.com>
	<7d1d9c250908111442kec430c1me20cc02d3e4fd60c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7d1d9c250908111442kec430c1me20cc02d3e4fd60c@mail.gmail.com>
Cc: Linuxppc-dev@ozlabs.org, Sridhar Mahadevan <msridhar87@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 11, 2009 at 05:42:26PM -0400, Paul Gortmaker wrote:
>On Tue, Aug 11, 2009 at 10:09 AM, Sridhar Mahadevan<msridhar87@gmail.com> wrote:
>> Hi,
>> Am trying to compile my WRL 2.6.21 kernel for PPC architecture.
>> The processor am using is AMCC powerpc 440EP .
>
>This isn't really the best choice of forum for trying to get help like this.
>Most of the people here are focused on working with the latest development
>kernels, and won't have the time to go back and look at year-old kernels
>based on the now removed PPC architecture.
>
>Plus they won't necessarily have any knowledge of what the WRL specific
>changes may or may not contain.  If you have the opportunity to do so,
>the best choice for you would be to go through the normal WR support
>channels with full details of your problem.
>
>At a glance, it looks like you are trying to build with ARCH=powerpc, and
>yet I don't think (from memory) that the 4xx boards had migrated from
>ARCH=ppc until sometime around the 2.6.24-ish timeframe.

Basic support was in 2.6.22.  440EP was in 2.6.24.

josh
