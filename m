Return-Path: <dhbaird@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.239])
	by ozlabs.org (Postfix) with ESMTP id 1F573DDE17
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Jan 2008 10:49:48 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so1087409nzh.39
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Jan 2008 15:49:47 -0800 (PST)
Message-ID: <440abda90801141549h40fd3facu3758c34a4715c78b@mail.gmail.com>
Date: Mon, 14 Jan 2008 16:49:46 -0700
From: "David Baird" <dhbaird@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Problem booting Linux 2.6 on Virtex-4
In-Reply-To: <440abda90801141211m52bd0a3bk67014c6df2bf406c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <440abda90801132112y76f2899by4ef582c9b58fd6b6@mail.gmail.com>
	<62D97388-4D65-4B40-A0D1-847963FF0A16@upb.de>
	<440abda90801141211m52bd0a3bk67014c6df2bf406c@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Jan 14, 2008 1:11 PM, David Baird <dhbaird@gmail.com> wrote:
> I am now trying to experiment with the hardware and see if I can find
> a hardware reference design.  I will let you know what I figure out.

Okay, I got something to work.  I had been using EDK 9.1i.  Today, I
got hold of a copy of EDK 9.2i and I tried out a reference design that
comes with EDK.  Voila!  The aliasing problem seems to have vanished.

So, basically, I still don't know why there was an aliasing problem in
the first place.  But, now something works.  I will still try to
figure out what the original problem was...

-David
