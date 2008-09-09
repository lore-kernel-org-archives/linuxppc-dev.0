Return-Path: <jwboyer@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id A9DC6DDFEE
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Sep 2008 22:15:57 +1000 (EST)
Received: by gxk14 with SMTP id 14so9964489gxk.9
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Sep 2008 05:15:56 -0700 (PDT)
Date: Tue, 9 Sep 2008 08:15:08 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Subject: Re: [PATCH] powerpc/44x: Add hwmon support to Sequoia device tree
Message-ID: <20080909121508.GA16041@yoda.jdub.homelinux.org>
References: <200809041155.02927.matthias.fuchs@esd-electronics.com>
	<48C29CA3.80806@grandegger.com>
	<20080908160332.GA12679@ld0162-tx32.am.freescale.net>
	<200809091352.29472.matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200809091352.29472.matthias.fuchs@esd-electronics.com>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 09, 2008 at 01:52:29PM +0200, Matthias Fuchs wrote:
>On Monday 08 September 2008 18:03, Scott Wood wrote:
>> On Sat, Sep 06, 2008 at 05:07:15PM +0200, Wolfgang Grandegger wrote:
>> > How about "dtt"? That's what we use in U-Boot for digital temperature
>> > sensors as well.
>> 
>> I vote against any acronyms that are not very well known.  Even knowing
>> that it's supposed to be "digital temperature <something>", I can't
>> figure out what the <something> is.  Not having the context that it
>> relates to temperature, I wouldn't have a clue what "dtt" is.
>> 
>> hwmon is concise and fairly obvious, and unlike "temp" could be
>> meaningfully used with chips that also monitor voltages, fan speeds, etc.
>> 
>> -Scott
>
>Uh, thanks Scott. Now we got it. I am fully with you and my "V2" patch
>should make everybody happy.
>
>So, let's apply this patch.

I already have it queued up.

josh
