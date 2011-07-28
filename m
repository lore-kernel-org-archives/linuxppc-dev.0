Return-Path: <vijay.t.nikam@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0621FB6F68
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 28 Jul 2011 16:27:55 +1000 (EST)
Received: by fxh10 with SMTP id 10so1000820fxh.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Jul 2011 23:27:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPUj1OOqRp-4h=7=x277P0cPSUJT4eCaxfCo0AAeA810hrb8Rg@mail.gmail.com>
References: <35CC4C9595855B43903A67B297EFA8E3C544FD@HYD-MKD-MBX01.wipro.com>
	<CAGn8Sby3Swk8zXxDXnXDBM+bDn=RV2cmvqvwXZM+05P=Z1FMAg@mail.gmail.com>
	<CAPUj1OOqRp-4h=7=x277P0cPSUJT4eCaxfCo0AAeA810hrb8Rg@mail.gmail.com>
Date: Thu, 28 Jul 2011 11:57:51 +0530
Message-ID: <CAGn8SbyD7CSmQVuXnz571UQZkqz1GAmk+TGMvL4rt7e5V6RdDQ@mail.gmail.com>
Subject: Re: HELP:PowerPc-Linux kernel
From: Vijay Nikam <vijay.t.nikam@gmail.com>
To: MJ embd <mj.embd@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: naresh.kamboju@wipro.com, linuxppc-dev@lists.ozlabs.org, cort@fsmlabs.com,
	linas@austin.ibm.com, hollis@austin.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Yes

/Vijay Nikam

On Thu, Jul 28, 2011 at 11:00 AM, MJ embd <mj.embd@gmail.com> wrote:
> Have you every worked on device trees before?
>
> On 7/28/11, Vijay Nikam <vijay.t.nikam@gmail.com> wrote:
>> Hello,
>>
>> Start with looking at the configuration of the board done which is
>> similar to yours
>> or based on the same CPU as yours. It is important to know role of
>> device tree so
>> read the documentation and understand the syntax and concept of device
>> tree. Once
>> the complete concept is understood then you should start the
>> configuration and achieve
>> successful creation of kernel image.
>>
>> Take a step forward and do some hands on. If any problem occurs then
>> post for specific help,
>> as porting itself is a big task and dosent have really straight forward
>> steps.
>> Good Luck
>>
>> Kind Regards,
>> Vijay Nikam
>>
>> On Wed, Jul 27, 2011 at 8:33 PM, <naresh.kamboju@wipro.com> wrote:
>>>
>>> Hi,
>>>
>>>
>>>
>>> I have take up the new assignment =A0Board bring up activity with Linux
>>> kernel on PowerPC MPC8272.
>>>
>>> I have been searching Linux bring up on PowerPC processor in Google and
>>> IBM wiki and not found good stuff.
>>>
>>> It would be more helpful for me if you could share related documents.
>>>
>>>
>>>
>>> Best regards
>>>
>>> Naresh Kamboju
>>>
>>>
>>>
>>> Please do not print this email unless it is absolutely necessary.
>>>
>>> The information contained in this electronic message and any attachment=
s
>>> to this message are intended for the exclusive use of the addressee(s) =
and
>>> may contain proprietary, confidential or privileged information. If you
>>> are not the intended recipient, you should not disseminate, distribute =
or
>>> copy this e-mail. Please notify the sender immediately and destroy all
>>> copies of this message and any attachments.
>>>
>>> WARNING: Computer viruses can be transmitted via email. The recipient
>>> should check this email and any attachments for the presence of viruses=
.
>>> The company accepts no liability for any damage caused by any virus
>>> transmitted by this email.
>>>
>>> www.wipro.com
>>>
>>> _______________________________________________
>>> Linuxppc-dev mailing list
>>> Linuxppc-dev@lists.ozlabs.org
>>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>
>
>
> --
> -mj
>
