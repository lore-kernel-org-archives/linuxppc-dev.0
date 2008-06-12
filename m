Return-Path: <jewirth@googlemail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id 12EB1DE147
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jun 2008 18:14:12 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so726158anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jun 2008 01:14:11 -0700 (PDT)
Message-ID: <f944af2a0806120114o13a8f29u369ddb224d7d4495@mail.gmail.com>
Date: Thu, 12 Jun 2008 10:14:11 +0200
From: "Jens Wirth" <jewirth@googlemail.com>
To: "Andrew Schmidt" <andrewgschmidt@gmail.com>, linuxppc-embedded@ozlabs.org
Subject: Re: PPC to PowerPC Migration
In-Reply-To: <1A76658A-B5BB-4A48-B81A-A0F7096C2943@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <c443b0db0806101048t1df8c11ag456fbc352709966b@mail.gmail.com>
	<161B3BAD77161449A144FF054231C3D6022A3E4A@uss-am-xch-01.am.trimblecorp.net>
	<f608b67d0806110655v19dac162wc3adfc8939b5c40a@mail.gmail.com>
	<D61182AC8012EA4EBC531B3AF23BE10960355D@tranzeo-mail2.12stewart.tranzeo.com>
	<20080611123254.64fabf64@vader.jdub.homelinux.org>
	<D61182AC8012EA4EBC531B3AF23BE109603578@tranzeo-mail2.12stewart.tranzeo.com>
	<20080611133247.0ac8b7c6@zod.rchland.ibm.com>
	<1A76658A-B5BB-4A48-B81A-A0F7096C2943@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jun 11, 2008 at 9:36 PM, Andrew Schmidt
<andrewgschmidt@gmail.com> wrote:
> First off, thank you everyone for replying, I must admit I was only
> expecting a few people to reply, but this is great.  I certainly am
> interested in any help I can get.  I suspect my first task is to go over the
> information given and then start to draft up a simple text file.  I am more
> experienced with the Xilinx PPC so initially the documentation may seems a
> little biased, but if anyone with other areas of expertise (as is evident
> from the emails received thus far) wants to help broaden it, that would be
> great.  I will get back to you shortly with my first "attempt."

I'm currently working with a custom design on a Xilinx ML300 board
to evaluate the realtime capabilities of the linux kernel with rt-patches.
Since this is my first experience with embedded Linux I had the most
trouble with understanding the coherences of the most general stuff
like the difference between ppc and powerpc as well as the need for
a device tree within powerpc but not ppc. Everything is documented
very well for it's own, but I would appreciate to see a documentation
that gives a bit more overview to the subject which is important for
beginners.

Well, I'm going to document my work from the system design using
EDK and ISE through to creating a running linux from scratch based
on this design. I'd like to support your documentation as much as I can.

Regards,
Jens Wirth
