Return-Path: <arnd.bergmann@de.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F232C67BF5
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 08:21:22 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAGLLKVf027249
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 16:21:20 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAGLK5hG418632
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 14:20:05 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAGLK51B019514
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 14:20:05 -0700
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC/PATCH 0/9] More xmon cell patches
Date: Thu, 16 Nov 2006 22:20:02 +0100
References: <1163661800.406227.631357998554.qpush@cradle>
In-Reply-To: <1163661800.406227.631357998554.qpush@cradle>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611162220.02845.arnd.bergmann@de.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 16 November 2006 08:23, Michael Ellerman wrote:
> This is an updated series of xmon cell patches, it replaces the series
> of three I sent earlier (Nov 3rd).
> 
> It fixes the xmon sparse warnings, updates 'ss, adds 'sd' and 'sdi'
> commands to xmon - and incorporates updated disassembly code. Finally
> we make the disassembly optional for folks looking for a smaller kernel.
> 
> I haven't signed-off this series, as I'm not sure whether that's the
> right thing to do for the binutils code - which I obviously didn't write.
> When I know, I'll resend with signed-offs or whatever is appropriate.
> 
> The update of the ppc-dis.c code is RFC, I just thought I'd do it while I
> was there. But I haven't tested it thoroughly.

Thanks for the update. I'll put them into my 2.6.19-rc based tree, but I
won't backport them to 2.6.18, in case anyone is wondering.

> I think you have the first three of these in CVS? The first two should be
> unchanged, but the third one has changed for the better and should probably
> be updated if possible.

I would prefer if you didn't do this, as it breaks my scripts when dealing
with multiple trees containing the same patches. Please either change the
subject of the replacement patch, or put the update into another patch
on top of it. It's no problem if your patches go right into powerpc.git,
but if you want me to forward them, I'd rather fold the patches myself.

Paul, are you taking these patches directly, or should I repost them
to you along with my other stuff for 2.6.20?

	Arnd <><
