Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id A9A36DDFB4
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 15:07:48 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 31so258687yxl.39
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 22:07:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090418003745.7dce8f47@lappy.seanm.ca>
References: <20090406175825.76bb969c__7633.03726348585$1239055251$gmane$org@lappy.seanm.ca>
	<Pine.LNX.4.64.0904172008310.5178@t2.domain.actdsltmp>
	<20090418003745.7dce8f47@lappy.seanm.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 17 Apr 2009 23:07:31 -0600
Message-ID: <fa686aa40904172207sc0f923eoefe8fb0a2703d548@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Update Warp to use leds-gpio driver
To: Sean MacLennan <smaclennan@pikatech.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Trent Piepho <xyzzy@speakeasy.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 17, 2009 at 10:37 PM, Sean MacLennan
<smaclennan@pikatech.com> wrote:
> On Fri, 17 Apr 2009 20:12:50 -0700 (PDT)
> "Trent Piepho" <xyzzy@speakeasy.org> wrote:
>
>> On Mon, 6 Apr 2009, Sean MacLennan wrote:
>> > Now that leds-gpio is a proper OF platform driver, the Warp can use
>> > the leds-gpio driver rather than the old out-of-kernel driver.
>> >
>> > One side-effect is the leds-gpio driver always turns the leds off
>> > while the old driver left them alone. So we have to set them back to
>> > the correct settings.
>>
>> Originally, I had the OF bindings support this feature, see
>> http://article.gmane.org/gmane.linux.kernel/749094
>>
>> Maybe this would be a better way to do it? =A0It avoids the glitch in
>> the leds, is less code overall, and can be use by other devices that
>> might want this same behavior.
>
> Yes, that is a cleaner way to handle the LEDs. Do you know why this
> patch wasn't accepted at the time? A quick google shows that Grant
> Likely acked it.
>
> The patch will no longer apply since default state does not exist.

It got left here:

On Sun, Jan 11, 2009 at 7:39 AM, Richard Purdie <rpurdie@rpsys.net> wrote:
> On Sun, 2009-01-11 at 04:58 -0800, Trent Piepho wrote:
>> It doesn't seem right to merge someone's patches together, make a very
>> small change, and then no longer credit them as the author.  Seems like =
it
>> defeats the purpose of the SOB lines for tracing the train of custody to=
o.
>> If someone looks to see where the code came from, it will look like you
>> wrote it.  Maybe Freescale will say Intel stole our code?  Without the S=
OB,
>> what record is there in git that Freescale gave permission to put the co=
de
>> in the kernel?
>>
>> I also put some significant effort into writing informative commit
>> messages, which have been lost.  Along with Grant's acks for my patches.
>
> It also doesn't make sense to make three changes adding different
> interfaces and rearranging the same section of code three different
> times. I'm dropping the patch, please send me a merged version of those
> patches with a commit message you're happy with. If you want Acked-by
> lines, we'll have to wait for them on the new patch as I'm going to do
> this exactly by the book regardless of time pressures now. Please
> indicate who you want Ack-ed by lines from so I know who to wait for.
> Also, you'd better exclude the suspend/resume change and credit me for
> the bitfield change, just to be 100% sure this is all legally accurate.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
