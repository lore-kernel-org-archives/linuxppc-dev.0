Return-Path: <jacmet@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by ozlabs.org (Postfix) with ESMTP id A5163DDE3A
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2008 18:10:39 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so517925fga.39
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2008 01:10:37 -0700 (PDT)
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] bootwrapper: support u-boot multi component images
References: <1221504833-5096-1-git-send-email-jacmet@sunsite.dk>
	<20080919075653.GA10241@secretlab.ca>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Fri, 19 Sep 2008 10:10:34 +0200
In-Reply-To: <20080919075653.GA10241@secretlab.ca> (Grant Likely's message of
	"Fri\, 19 Sep 2008 00\:56\:53 -0700")
Message-ID: <87myi4k139.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:

Hi,

 Grant> On Mon, Sep 15, 2008 at 08:53:53PM +0200, Peter Korsgaard wrote:
 >> +   uImage.thinx:	U-Boot multi component image. Similar to uImage,

 Grant> Change this to "uImage.%:" to match the rest of this document.

Argh, guess what my platform is called ;)

 >> -	otheros.bld *.dtb
 >> +	otheros.bld uImage.* *.dtb

 Grant> Actually, you can probably make this "uImage*" instead because plain
 Grant> 'uImage' targets are missing from this list.

Ok, will do.

 >> -miboot|uboot)
 >> +miboot|uboot|uboot-*)

 Grant> Similarly, uboot and uboot-* can probably be collapsed to 'uboot*'

Yeah, I kept it like this to keep it clear that it doesn't impact the
normal uImage support - Will fix.

I'll send an updated patch.

-- 
Bye, Peter Korsgaard
