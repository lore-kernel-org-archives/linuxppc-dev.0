Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id 56194DDE17
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Sep 2008 22:07:58 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so501557pyi.27
	for <linuxppc-dev@ozlabs.org>; Sat, 06 Sep 2008 05:07:55 -0700 (PDT)
Date: Sat, 6 Sep 2008 08:07:47 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] powerpc/44x: Add hwmon support to Sequoia device tree
Message-ID: <20080906120747.GA21519@vader.jdub.homelinux.org>
References: <200809041155.02927.matthias.fuchs@esd-electronics.com>
	<200809041628.29460.matthias.fuchs@esd-electronics.com>
	<200809041641.57614.matthias.fuchs@esd-electronics.com>
	<200809051219.43906.sr@denx.de>
	<20080905160017.GA22310@ld0162-tx32.am.freescale.net>
	<20080905201703.0586e131@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080905201703.0586e131@lappy.seanm.ca>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 05, 2008 at 08:17:03PM -0400, Sean MacLennan wrote:
>On Fri, 5 Sep 2008 11:00:18 -0500
>"Scott Wood" <scottwood@freescale.com> wrote:
>
>> On Fri, Sep 05, 2008 at 12:19:43PM +0200, Stefan Roese wrote:
>> > > +
>> > > +				hwmon@48 {
>> > 
>> > Not sure if we shouldn't use
>> > 
>> >                                 ad7414@48 {
>> > 
>> > here. This is the way it is already done in warp.dts.
>> 
>> We shouldn't.  Node names are supposed to be generic:
>> http://playground.sun.com/1275/practice/gnames/gnamv14a.html
>
>Damn. Where were you a year ago when I first introduced this? ;)
>
>And if it is really supposed to be generic, would temp@48 be a
>better name since this is basically a generic temperature chip?
>
>Now that the i2c driver is a full of platform driver, I think I
>can change the name with no repercussions. So I can live with whatever
>decision is made. Can't do anything about the systems that are out in
>the field though....

It's just the unit-name that should be generic, not the compatible.  The
only thing unit-name is used for is path lookup and distinguishing between
similar hardware units.  I don't think either is a problem in this case.

josh
