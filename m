Return-Path: <hpa@zytor.com>
Received: from terminus.zytor.com (terminus.zytor.com [192.83.249.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5A6ADDDFCF
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jul 2007 04:36:56 +1000 (EST)
Message-ID: <468E8BBF.9020907@zytor.com>
Date: Fri, 06 Jul 2007 11:36:47 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Too verbose compat_ioctl messages?
References: <Pine.LNX.4.62.0707061431360.1203@pademelon.sonytel.be>	<468E6E33.3040000@zytor.com>
	<p737ipd1jsg.fsf@bingen.suse.de> <468E8B07.2030404@goop.org>
In-Reply-To: <468E8B07.2030404@goop.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Andi Kleen <andi@firstfloor.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Hiroaki Fuse <Hiroaki_Fuse@hq.scei.sony.co.jp>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jeremy Fitzhardinge wrote:
>>
>> ENOTTY is so excessively misnamed that it is actually surprising
>> anybody ever got that "right" (for very small values of right i guess)
> 
> But it *isn't* a typewriter.  Of course, it's not a giraffe either.
> 

The union of things that are not typewriters and not giraffes are rather
large, indeed.

This is getting philosophical.

	-hpa
