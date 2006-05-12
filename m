Return-Path: <thiagogalesi@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id D66BC679F2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 May 2006 10:49:03 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so220129ugf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 May 2006 17:49:01 -0700 (PDT)
Message-ID: <82ecf08e0605111749l5a0d7758y704e98b86778f2ea@mail.gmail.com>
Date: Thu, 11 May 2006 21:49:01 -0300
From: "Thiago Galesi" <thiagogalesi@gmail.com>
To: "Jayanta Das" <JDas@alphion.com>
Subject: Help: Linux porting to custom target hw
In-Reply-To: <8584FDC94AFF7640B17B8A89B23B19B331C6BA@sbsserver.AlphionCorp.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <8584FDC94AFF7640B17B8A89B23B19B331C6BA@sbsserver.AlphionCorp.local>
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

>
> My specific question was what do I need to change in the kernel and U-Boo=
t
> source to boot my target HW. Is flash location and the memory map only th=
ing
> I need to worry about or I need to do something more. E.g. I am looking f=
or
> a document which will specify the LSP specific files.

I'm not very familiar with UBoot but most of the changes will be made
there, not in the kernel (that is, memory size, memory mappings, etc)

AFAIK the only thing you'll have to set up in the kernel is the flash
location, size and configuration (that is, if it is 16 bits, 32 bits,
2x16 bits , etc, etc)

Thiago
