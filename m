Return-Path: <grant.likely@secretlab.ca>
Received: from outbound-mail-29.bluehost.com (outbound-mail-29.bluehost.com
	[67.138.240.211]) by ozlabs.org (Postfix) with SMTP id 02BC968921
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 31 Dec 2005 15:05:25 +1100 (EST)
Message-ID: <43B601CC.1000102@secretlab.ca>
Date: Fri, 30 Dec 2005 20:58:04 -0700
From: Grant Likely <grant.likely@secretlab.ca>
MIME-Version: 1.0
To: "David H. Lynch Jr." <dhlii@dlasys.net>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
References: <11359385991901-git-send-email-grant.likely@secretlab.ca>
	<43B5E37A.4020008@dlasys.net>
In-Reply-To: <43B5E37A.4020008@dlasys.net>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [PATCH 8/8] Add support for Xilinx ML403 reference design
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

David H. Lynch Jr. wrote:
> 	I am working on a port of 2.6.14.5 to the Pico E-12 which is a Xilinx
> Virtex-IV system in a CF card. It is very similar to the ML403 but with
> alot less hardware. I would love to be able to pull a whole tree of the
> stuff you are working on - is there a git, svn, or cvs tree that the
> linuxppc-embedded patches are getting merged into ? and How can it be
> accessed ?
I don't have a public git tree at the moment for the xilinx virtex
stuff.  I can certainly create and maintain one if there is demand.  I
guess it depends on how many people want to colaborate on V2Pro/V4
support.  Anyone else interested?

> 	Right now I am trying to get /init to run - actually it runs but I am
> not getting IO on the console. Anyway, I hope to put out a collection of
> patches when I have it really working. Aside from the Pico  e-12 itself,
> I have Uartlite drivers that are consistent with the way the rest of the
> 2.6 serial drivers are layed out as well as a custom serial driver
> specific to the E-12. The E-12 stuff might not make it into the
> distribution kernel, but I would think there might be some interest in
> the UartLite driver.
Since the E-12 is a commercially available board, it would be useful to
have the patches on the ML, even if they don't get applied to mainline.

> 
> 	Anyway it would be nice to work against whatever all the
> linuxppc-embedded patches are going into.
I'm working off the mainline linux-2.6 tree from kernel.org.  PPC
patches are getting merged into mainline frequently.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 663-0761
