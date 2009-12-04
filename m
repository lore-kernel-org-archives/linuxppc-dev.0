Return-Path: <jwboyer@gmail.com>
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com
	[209.85.211.181]) by ozlabs.org (Postfix) with ESMTP id 41346B7BBD
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Dec 2009 22:01:07 +1100 (EST)
Received: by ywh11 with SMTP id 11so2271405ywh.9
	for <linuxppc-dev@ozlabs.org>; Fri, 04 Dec 2009 03:01:06 -0800 (PST)
Date: Fri, 4 Dec 2009 06:00:56 -0500
From: Josh Boyer <jwboyer@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: BUG: Bad page map in process
Message-ID: <20091204110055.GP14279@hansolo.jdub.homelinux.org>
References: <20091203141853.3eafba47@lappy.seanm.ca>
	<1259917707.2076.1271.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1259917707.2076.1271.camel@pasglop>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 04, 2009 at 08:08:27PM +1100, Benjamin Herrenschmidt wrote:
>On Thu, 2009-12-03 at 14:18 -0500, Sean MacLennan wrote:
>> With 2.6.32 I sometimes get lots and lots of "Bad page map" errors as
>> shown below. I believe these started in 2.6.32-rc8 or possibly
>> 2.6.32-rc7. Pika just switched to 2.6.31 so I have been concentrating
>> on that release, and not really testing the 2.6.32 stream.
>> 
>> I wish I could give more info, but I don't really even have the time to
>> write this email :( I am hoping somebody will have a eureka moment.
>
>That's a concern. Remind me what CPU / MMU type is Pika using ?

440EP

josh
