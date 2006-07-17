Return-Path: <leisun124@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by ozlabs.org (Postfix) with ESMTP id DD7DB67B91
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Jul 2006 04:29:19 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id p77so25666nfc
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Jul 2006 11:29:17 -0700 (PDT)
Message-ID: <f9a7e7a80607171129r3b541087l73a57bc3c8108e43@mail.gmail.com>
Date: Mon, 17 Jul 2006 14:29:16 -0400
From: "Lei Sun" <leisun124@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: where is the kernel source for ppc embedded?(may sound stupid)
In-Reply-To: <528646bc0607171015i5a6048aaje2d9ec557fbde22d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <f9a7e7a80607170844v1626009at43766449872bd25f@mail.gmail.com>
	<528646bc0607171015i5a6048aaje2d9ec557fbde22d@mail.gmail.com>
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

I looked at that website, and it suggested downloading kernel from
kernel.org. I've downloaded , but apparently, it's different with what
I have right now, there is no ADS8260 and PQ2FADS-VR board type . I
think there are some patch for that board already, where can I find
those patches?

Thanks
ls

On 7/17/06, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 7/17/06, Lei Sun <leisun124@gmail.com> wrote:
> > Hi:
> >   I am taking another guys porting work, he downloaded 2.4.30 for ppc.
> > I was looking at http://www.denx.de/, and kernel.org, didn't feel like
> > it was from there, since the current source tree only  have arch/ppc
> > directory, no other arch specific tree.
> >   So where i should download 2.4.30 with all patch applied?
>
> http://penguinppc.org/kernel/
>
> --
> Grant Likely, B.Sc. P.Eng.
> Secret Lab Technologies Ltd.
> grant.likely@secretlab.ca
> (403) 399-0195
>
