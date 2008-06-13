Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 80481DDEEF
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 15:12:26 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so815900anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 22:12:24 -0700 (PDT)
Message-ID: <fa686aa40806122212s50a76750g7181cacb7e161bd0@mail.gmail.com>
Date: Thu, 12 Jun 2008 23:12:24 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"David Jander" <david.jander@protonic.nl>, linuxppc-dev@ozlabs.org,
	linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 1/2] Added support for PRTLVT based boards (MPC5121)
In-Reply-To: <20080613041943.GC29451@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200806121344.26883.david.jander@protonic.nl>
	<fa686aa40806120710g67761ectfee1e3f0916b0eb@mail.gmail.com>
	<20080613041943.GC29451@yookeroo.seuss>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 12, 2008 at 10:19 PM, David Gibson
<david@gibson.dropbear.id.au> wrote:
> On Thu, Jun 12, 2008 at 08:10:47AM -0600, Grant Likely wrote:
> [snip]
>> > +               i2ccontrol@1760 {
>> > +                       compatible = "fsl,mpc5121-i2c-ctrl";
>> > +                       reg = <0x1760 0x8>;
>> > +               };
>> > +
>> > +               diu@2100 {
>>
>> (nitpick) There is a recommended practice that says node names should
>> be generic as much as possible, so I think this should probably be
>> video@2100.  The compatible value is fine.
>
> If this is a video display device, the recommended generic name is
> "display@XX", not "video@XX".

heh; oops.  I should know better and I stand corrected.  :-)

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
