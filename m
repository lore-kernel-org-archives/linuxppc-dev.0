Return-Path: <xenidis@gmail.com>
Received: from mail-yw0-f42.google.com (mail-yw0-f42.google.com
	[209.85.213.42]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7C975B6F80
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Aug 2011 03:31:47 +1000 (EST)
Received: by mail-yw0-f42.google.com with SMTP id 3so816413ywb.15
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2011 10:31:47 -0700 (PDT)
Sender: "xenidis@gmail.com" <xenidis@gmail.com>
Subject: Re: union/struct representations for MAS Registers
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Jimi Xenidis <jimix@pobox.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AE25@saturn3.aculab.com>
Date: Wed, 10 Aug 2011 12:31:45 -0500
Message-Id: <B8DCD489-B158-40BB-87BD-873A3591737F@pobox.com>
References: <AE90C24D6B3A694183C094C60CF0A2F6D8AE25@saturn3.aculab.com>
To: "David Laight" <David.Laight@ACULAB.COM>
Cc: Linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 10, 2011, at 12:25 PM, David Laight wrote:

> 
>> I have some and use them in some code, they represent ISA 
>> 2.06 MAVN=1 (version 2)
>> Can I keep them?
>> if so, should I put them somewhere useful to others?
>> 
>> Examples:
>> union mas1 {
>> 	u32 _val;
>> 	struct {
>> 		u32 v:1;
>> 		u32 iprot:1;
>> 		u32 tid:14;
>> 		u32 _reserved_1:2;
>> 		u32 ind:1;
>> 		u32 ts:1;
>> 		u32 tsize:4;
>> 		u32 _reserved_2:8;
>> 	};
>> };
> 
> Bitfields are rather non-portable, the compiler has a lot of choice
> about how to align the bits in memory.

I'm ok with the masking stuff.
However, I'm actually surprised this is true given the maturity of our ABIs.

-JX
> Their use to map anything physical is doomed to portabilily issues.
> 
> 	David
> 
> 
