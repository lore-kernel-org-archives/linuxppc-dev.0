Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id 11F1367B91
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Jul 2006 04:52:57 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so1859524ugf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Jul 2006 11:52:56 -0700 (PDT)
Message-ID: <528646bc0607171152o1b4ce429m17c18f13763060c6@mail.gmail.com>
Date: Mon, 17 Jul 2006 12:52:55 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Lei Sun" <leisun124@gmail.com>
Subject: Re: where is the kernel source for ppc embedded?(may sound stupid)
In-Reply-To: <f9a7e7a80607171129r3b541087l73a57bc3c8108e43@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <f9a7e7a80607170844v1626009at43766449872bd25f@mail.gmail.com>
	<528646bc0607171015i5a6048aaje2d9ec557fbde22d@mail.gmail.com>
	<f9a7e7a80607171129r3b541087l73a57bc3c8108e43@mail.gmail.com>
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

On 7/17/06, Lei Sun <leisun124@gmail.com> wrote:
> I looked at that website, and it suggested downloading kernel from
> kernel.org. I've downloaded , but apparently, it's different with what
> I have right now, there is no ADS8260 and PQ2FADS-VR board type . I
> think there are some patch for that board already, where can I find
> those patches?

Try the "no longer used" tree listed at the bottom of the page if you
want a 2.4 kernel.

If you want 2.6, use kernel.org

I don't know if ADS8260 or PQ2FADS-VR support is in either tree.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
