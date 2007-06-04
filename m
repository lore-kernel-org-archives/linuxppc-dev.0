Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Bernhard Walle <bwalle@suse.de>
Subject: Re: kexec on PS3 
In-reply-to: <20070604095433.GB29457@suse.de> 
References: <20070604095433.GB29457@suse.de>
Date: Mon, 04 Jun 2007 20:50:14 +1000
Message-ID: <7629.1180954214@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Stefan Assmann <sassmann@suse.de>,
	kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> At http://www.powerdeveloper.org/platforms/cell/playstation there are
> some patches that are required for kexec-tools to use kdump on the
> Play Station 3. Wouldn't it make sense to merge them in kexec-tools
> testing?

Yes.

> kexec-tools-1.101-bootargs-align.patch is already discussed here in
> the thread "kexec ppc64: fix misaligned cmdline". But what about
> kexec-tools-1.101-ps3-rmo_top-max.patch and
> kexec-tools-1.101-align-dtstruct.patch?

This doesn't fix the problem mentioned by Milton.  

> I'm not the author, and I don't know how to contact the author of that
> patches, but I'd like to see them in mainline kexec-tools.

Bugger.  It would make sense to merge them, especially since they are
fixing generic powerpc problems.

If you can get a signed off by the author, that would be awesome!

Mikey
