Return-Path: <glikely@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by ozlabs.org (Postfix) with ESMTP id AB2E1679F5
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 May 2006 01:31:57 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id l24so538933nfc
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 05 May 2006 08:31:56 -0700 (PDT)
Message-ID: <528646bc0605050831y75abe02dib2abe85ee88374d1@mail.gmail.com>
Date: Fri, 5 May 2006 09:31:56 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Chris Dumoulin" <cdumoulin@ics-ltd.com>
Subject: Re: Moving from 2.4 to 2.6 kernel
In-Reply-To: <445B5597.9010801@ics-ltd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <445A3AB1.7040405@ics-ltd.com>
	<528646bc0605041111o1b652d60w3f5847a19abe5c95@mail.gmail.com>
	<445A534D.8090800@ics-ltd.com>
	<528646bc0605041304q695a183ao68a4720e974ad4f@mail.gmail.com>
	<445B5597.9010801@ics-ltd.com>
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

On 5/5/06, Chris Dumoulin <cdumoulin@ics-ltd.com> wrote:
> I generated the xparameters_ml300.h file and built my kernel configured
> for the ML300 board, but I still had the same problem. I'm wondering if
> there's something in the hardware that's not being setup by u-boot as
> the linux kernel expects it. I'm looking through the ML300 code in
> u-boot 1.1.4 to see if can spot anything that's being done in there
> that's not being done in my u-boot code. Do you have any ideas about
> some hardware (or other)  initialization that I could be neglecting to
> do in u-boot that might cause things to hang?

Probably not;  The nice thing about the V2Pro is that there is pretty
much no setup that needs to be done.  The bitstream takes care of
configuring SDRAM.  :).  For my daily work; I don't even use u-boot.=20
I'm downloading a zImage directly through my BDI 2000.  (But u-boot
does work for me too)

Can you post your xparameters file?  (Or email it to me directly)

Are you using a full UART or UART lite?

> On a similar note, is there any guide to porting u-boot that I could
> read that would enumerate all the steps I should be taking in u-boot? I
> know the README in the u-boot source basically says to browse the
> mailing list (which I'm doing), read the DULG (which I've done), and
> read the source (which I'm also doing), but some kind of succinct guide
> would be nice, if it exists.

Not that I know of; I had to pile throught the same stuff to learn it.

> Interactive Circuits and Systems Ltd.
> 5430 Canotek Road
> Ottawa, ON

Hey; you going to OLS this year?

Cheers,
g.

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 399-0195
