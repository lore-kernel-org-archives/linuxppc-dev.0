Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B836E67A83
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Mar 2005 18:48:49 +1100 (EST)
Date: Mon, 21 Mar 2005 23:48:46 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: "Lawrence E. Bakst" <ml@iridescent.org>
Message-ID: <20050322074846.GA8379@gate.ebshome.net>
References: <0.20050322_000905.tnt@patchsend.246tNt.com>
	<p0621020ebe656d463a67@mail.iridescent.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <p0621020ebe656d463a67@mail.iridescent.org>
Cc: ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Future of OCP
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Mar 21, 2005 at 11:04:44PM -0800, Lawrence E. Bakst wrote:
> Q1: OK, so I gather the OCP system which until recently used to be 
> in a separate OCP tree and was recently integrated into 2.6 is going 
> away?

There is a trend use platform device instead of OCP. There are no 
conceptual differences though, just a more convenient way from cross 
platform POV - OCP is PPC specific, platform device - generic 
solution. 

IMHO there is little gain from converting 4xx from OCP platform device 
(except being just like other PPC subarchs :). That's the main reason 
it hasn't been done yet. Matt seems to be busy these days, I don't see 
a point, frankly, so we just waiting for a patch :).

> I had just started to do a 405 EP port of 2.6.11-rc4  based off of 
> the bubinga config.
> 
> Q2: Assuming yes, to Q1, any advice on how I should proceed, 
> continue on with an OCP port or wait for this new stuff?

Well, I wouldn't worry much. These changes will affect mostly device 
drivers and some platform stuff. Board code (which I assume you are 
working on) won't be changed significantly if any. As I said, platform 
device stuff is conceptually similar to OCP, so changes will be mostly 
cosmetic.

> Q3: How does one stay in the loop on this stuff? With only about 3 
> messages posted in this group and none in linuxppc-dev I am clearly 
> in the wrong place. I feel like I missed the conversation. Where was 
> it?

Most discussions happen on IRC (for more info see 
http://www.penguinppc.org). Some people think it's a kind of "elitist 
circle" which requires some special invitation :), which is not true, 
obviously.

--
Eugene
