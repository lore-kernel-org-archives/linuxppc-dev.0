Return-Path: <fkan@apm.com>
Received: from exprod5og113.obsmtp.com (exprod5og113.obsmtp.com [64.18.0.26])
	by ozlabs.org (Postfix) with SMTP id 0BF35B70D5
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jul 2010 12:02:46 +1000 (EST)
Received: by gwj16 with SMTP id 16so523619gwj.14
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jul 2010 19:02:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100730012650.GB24931@suse.de>
References: <12801701823001-git-send-email-fchen@apm.com>
	<20100726213704.GA16268@suse.de>
	<4C4E0449.2070108@caviumnetworks.com>
	<20100726220513.GA9671@suse.de> <20100726220809.GA9784@suse.de>
	<AANLkTinbTnrr9DCiSgKngAjaak=U0qDYcCxbNZR4Nm3D@mail.gmail.com>
	<20100726231616.GA25342@suse.de>
	<AANLkTikDpxcOj=TgD5697HOzPOanECGd4G6QaXZmoS98@mail.gmail.com>
	<20100730005045.GB22683@suse.de>
	<AANLkTikSH8_QXV2qsBR+vxsjvQwNdx2st3vfbRpfsMff@mail.gmail.com>
	<20100730012650.GB24931@suse.de>
Date: Thu, 29 Jul 2010 19:02:44 -0700
Message-ID: <AANLkTimiox6UbUnhSRLgC06S2kfcDOANA08gm3m++TXd@mail.gmail.com>
Subject: Re: [PATCH 1/2 v1.03] Add support for DWC OTG HCD function.
From: Feng Kan <fkan@apm.com>
To: Greg KH <gregkh@suse.de>
Content-Type: text/plain; charset=UTF-8
Cc: linux-usb@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>,
	linuxppc-dev@ozlabs.org, Mark Miesfeld <mmiesfeld@apm.com>,
	Ted Chan <tchan@apm.com>, Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 29, 2010 at 6:26 PM, Greg KH <gregkh@suse.de> wrote:
> On Thu, Jul 29, 2010 at 06:19:25PM -0700, Feng Kan wrote:
>> Hi Greg:
>>
>> On Thu, Jul 29, 2010 at 5:50 PM, Greg KH <gregkh@suse.de> wrote:
>> > On Thu, Jul 29, 2010 at 05:14:59PM -0700, Feng Kan wrote:
>> >> Hi Greg:
>> >>
>> >> We will change to a BSD 3 clause license header. Our legal counsel is
>> >> talking to Synopsis to make this change.
>> >
>> > Why BSD? =C2=A0You do realize what that means when combined within the=
 body
>> > of the kernel, right?
>> >
>>
>> FKAN: We will shoot for a dual BSD/GPL license such as the one in the HP
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Hil driver.
>
> What specific driver is this?

FKAN: this is driver/input/serio/hil_mlc.c and quite a number of others.

>
> And are you sure that all of the contributors to the code agree with
> this licensing change? =C2=A0Are you going to require contributors to
> dual-license their changes?
>
> If so, why keep it BSD, what does that get you?

FKAN: for one thing, to make it future proof on other submissions.

>
>> > Are you going to be expecting others to contribute back to the code
>> > under this license, or will you accept the fact that future
>> > contributions from the community will cause the license to change?
>
>
> You didn't answer this question, which is a very important one before I
> can accept this driver.

FKAN: Yes, all of the above. Our legal is working on that. I thought by def=
ault
           GPL defines the above statement.

>
>> >> We will resubmit once this is in place. Please let me know if you hav=
e
>> >> any additional concerns.
>> >
>> > My main concern is that you, and everyone else involved in the driver,
>> > never considered the license of the code in the first place and expect=
ed
>> > the kernel community to accept it as-is, placing the problem on us.
>>
>> FKAN: Please don't think this is the case, we gone through this exercise
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with Denx.
>
> What is "Denx"?

FKAN: U-Boot Denx.de

>
>> We had legal looking into the header before submission
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 to them and the kernel.
>
> Then what happened here? =C2=A0Just curious as to how the driver was publ=
ic
> for so long before someone realized this.
>

FKAN:  this was few years back. At the time we had the header changed
           so it was BSD like to be accepted by Denx.

>> > What will be done in the future to prevent this from happening again?
>>
>> FKAN: agreed, once bitten .... :)
>
> That didn't answer the question :)

FKAN: we have a system of checks for every patch that goes out. I will send
           out a guideline to all reviewer to make sure the header
follow kernel precedence.
           Legal is quite aware of the issue now too.

>
> thanks,
>
> greg k-h
>



--=20
Feng Kan
