Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910807291728sc46b19bmbff583a7f494d4a6@mail.gmail.com>
Date: Tue, 29 Jul 2008 20:28:27 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: verbose kernel debug
In-Reply-To: <9e4733910807291717g7096b8eas455964e0bbb637b9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910807291547p3ddd6b15nbe4516657e2e014f@mail.gmail.com>
	<488FA22C.5060100@freescale.com>
	<9e4733910807291612l5e0567d6t376c2f96c5169333@mail.gmail.com>
	<20080729234012.GA13708@secretlab.ca>
	<9e4733910807291709j49cacaa7gcc05f075f0691682@mail.gmail.com>
	<9e4733910807291717g7096b8eas455964e0bbb637b9@mail.gmail.com>
Cc: Scott Wood <scottwood@freescale.com>, ppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I finally figured out the right combo to turn it on. I was expecting
it to appear in the "Kernel Debugging" section but it was appearing
down lower.

Seems like this option should be defaulted on no matter what, and then
turn it off to save memory. It was the interaction with
CONFIG_EMBEDDED that confused me.

-- 
Jon Smirl
jonsmirl@gmail.com
