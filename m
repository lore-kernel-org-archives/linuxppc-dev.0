Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.184])
	by ozlabs.org (Postfix) with ESMTP id 1E9F9DDEF0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Aug 2007 02:34:41 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so1027152rvf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Aug 2007 09:34:40 -0700 (PDT)
Message-ID: <fa686aa40708130934v912eda2r691d2db30a9bc17c@mail.gmail.com>
Date: Mon, 13 Aug 2007 10:34:39 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: MPC5200 and Bestcomm
In-Reply-To: <9e4733910708130927l70163a80vf0362ee8649a6c29@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910708130927l70163a80vf0362ee8649a6c29@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/13/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> We're starting a new MPC5200 project and I'm trying to track down the
> best kernel to start from. Is Sylvain's tree at
> http://www.246tnt.com/mpc52xx/ a good place to start? The git URLs
> from the web page don't work. Everything 5200 related in the trees at
> Secret Labs already appears to be merged.
>
> Most of this work also appears to be in the Open Embedded tree's Ekifa
> support. Is that a better place to start?

It might be.  The major problem with MPC5200 is the Ethernet driver.
I believe both Domen and Sylvain have been working on drivers suitable
for arch/powerpc inclusion.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
