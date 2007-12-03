Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-va3-R.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9A7DCDDE44
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Dec 2007 14:34:00 +1100 (EST)
Message-ID: <4753791E.6020703@am.sony.com>
Date: Sun, 02 Dec 2007 19:33:50 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PPC BOOT] Create otheros.bld next to specified output file,
	not in $object directory.
References: <1196650083.13978.113.camel@pmac.infradead.org>
In-Reply-To: <1196650083.13978.113.camel@pmac.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse wrote:
> The bootwrapper script currently generates an 'otheros.bld' file in
> addition to the file specified by the -o option, when asked to build a
> wrapper for PS3.
> 
> It should do that in the same directory as the output, not the directory
> where the wrapper objects are kept (which might potentially not be
> writable when the script runs).


Seems reasonable for installs from read-only media.

 
> Arguably, the 'otheros.bld' ought to be created with the filename
> specified as the -o argument. But that's a more intrusive change.


Yes, I think it makes sense.  ps3-flash-util can handle any file
name, so there is no real reason to have it named otheros.bld.
 

> Signed-off-by: David Woodhouse <dwmw2@infradead.org>


Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
