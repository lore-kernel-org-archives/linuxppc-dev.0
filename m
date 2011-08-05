Return-Path: <jrnieder@gmail.com>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E0F78B6F65
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Aug 2011 03:53:27 +1000 (EST)
Received: by ywb26 with SMTP id 26so1984632ywb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 05 Aug 2011 10:53:24 -0700 (PDT)
Date: Fri, 5 Aug 2011 19:53:14 +0200
From: Jonathan Nieder <jrnieder@gmail.com>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: linux-image-2.6.39-2-powerpc: CHRP Pegasos2 boot failure
Message-ID: <20110805175314.GA17234@elie.gateway.2wire.net>
References: <20110617222943.2188.34712.reportbug@chrp.ab.bgc.com.au>
	<1308545397.11457.107.camel@localhost>
	<20110620222812.6cd7e862.andrewb@zagam.net>
	<1308711698.3093.285.camel@localhost>
	<20110623203654.04f151e1.andrewb@zagam.net>
	<1309126453.3093.1555.camel@localhost>
	<20110628125148.GA10884@iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110628125148.GA10884@iram.es>
Cc: Michael Ellerman <michael@ellerman.id.au>, 630845@bugs.debian.org,
	Ben Hutchings <ben@decadent.org.uk>, linuxppc-dev@lists.ozlabs.org,
	Andrew Buckeridge <andrewb@zagam.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

forwarded 630845 http://thread.gmane.org/gmane.linux.ports.ppc.embedded/43997
quit

Hi,

Gabriel Paubert wrote:
>>>> Andrew Buckeridge wrote:

>>>>> linux-image-2.6.36-trunk-powerpc_2.6.36-1~experimental.1_powerpc.deb
>>>>> linux-image-2.6.37-1-powerpc_2.6.37-1_powerpc.deb
>>>>> linux-image-2.6.37-2-powerpc_2.6.37-2_powerpc.deb
>>>>> These failed to boot. In all cases stuck at the spinner.
[...]
> What do you mean by the spinner? I've had very long boot times with 
> an apparently dead machine depending on graphics options.
>
> For now I'm running 2.6.39 with one patch for keyboard/mouse handling
> which is now upstream.
>
> I can try a more recent kernel on Thursday.

Thanks.  Please forgive my ignorance:

 - Gabriel, what options do you suggest for a reasonably fast boot?
   Does Debian's default configuration need corresponding changes?

 - Andrew, what do you mean by the spinner?  Could you take a photograph?

 - Has anything changed in the month or so since this report was last
   discussed?
