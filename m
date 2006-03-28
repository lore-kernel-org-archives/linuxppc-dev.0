Return-Path: <geoffrey.levand@am.sony.com>
Received: from mail8.fw-sd.sony.com (mail8.fw-sd.sony.com [160.33.66.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B9D0B679F8
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2006 07:30:29 +1100 (EST)
Message-ID: <44299CE1.2010404@am.sony.com>
Date: Tue, 28 Mar 2006 12:30:25 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Hollis Blanchard <hollis@penguinppc.org>
Subject: Re: make install on ppc
References: <f78eb6c06abb98fbc1cf8ae32bbf2268@penguinppc.org>
	<44298929.1060003@am.sony.com>
	<200603281402.02449.hollis@penguinppc.org>
In-Reply-To: <200603281402.02449.hollis@penguinppc.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hollis Blanchard wrote:
> On Tuesday 28 March 2006 13:06, you wrote:
>> Problem is for multi-platform binary builds, 'install' could mean different
>> things for the different platforms, so to support install, there needs
>> to be some way to tell the build system what 'install' means that also
>> works with the muti-platform makefile logic.  The current powerpc makefiles
>> don't have this, and it would take some non-trivial rework to add it.
> 
> That is for the distribution- or user-supplied installkernel script to deal 
> with.


To handle the situation I mentioned, the build system would need to either tell
the installkernel script what to do, or call different installkernel scripts,
so the build system itself needs to have some notion of what install means,
but as I mentioned, that is currently missing from the makefiles.


>> There is also the question of what install means when cross building.
> 
> So don't run make install when cross-compiling (unless of course your 
> installkernel script supports that).


But I would like to...


> I don't understand these objections. If someone's platform is so super-special 
> that a script couldn't possibly know how to install a kernel, just don't run 
> make install!


I guess you misunderstood me.  I'm not objecting nor saying it shouldn't be
done, just stating some of what needs to be done to make it work properly.
The logic needed is not trivial, and more work is needed than just adding
an 'install' target line to a makefile.


-Geoff
