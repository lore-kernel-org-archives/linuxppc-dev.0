Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id C6150DE2AF
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Aug 2008 02:14:04 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so470127anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 05 Aug 2008 09:14:03 -0700 (PDT)
Message-ID: <fa686aa40808050913s70ba599fi56f590fa0bd6d7dd@mail.gmail.com>
Date: Tue, 5 Aug 2008 10:13:58 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Mihaela Grigore" <grigore.mihaela@gmail.com>, linuxppc-embedded@ozlabs.org
Subject: Re: linux kernel under psim (powerpc emulator)
In-Reply-To: <78ef7ce10808050856g110b8c07s99ef9758b6326bf5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <78ef7ce10808050604h54b9b627r69e98c82c2cb464@mail.gmail.com>
	<fa686aa40808050822v3301af47xf29c8622d40d9a94@mail.gmail.com>
	<78ef7ce10808050856g110b8c07s99ef9758b6326bf5@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Aug 5, 2008 at 9:56 AM, Mihaela Grigore
<grigore.mihaela@gmail.com> wrote:
> what ?? Are you sure ? because i investigated qemu and pearpc a while
> ago and as far as i could find out neither could run a 2.6 kernel.
> Only 2.4.

Yes, Rob Landley has it working in his Firmware Linux tool:

http://www.landley.net/code/firmware/

g.

>
> Regards,
> Mihaela Grigore
>
> On Tue, Aug 5, 2008 at 4:22 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> On Tue, Aug 5, 2008 at 7:04 AM, Mihaela Grigore
>> <grigore.mihaela@gmail.com> wrote:
>>> Hello,
>>>
>>> Has anyone tried or knows if it is possible to run a 2.6 linux kernel
>>> under psim?
>>
>> I don't know about psim, but I do know that it will run under qemu.
>>
>> g.
>>
>> --
>> Grant Likely, B.Sc., P.Eng.
>> Secret Lab Technologies Ltd.
>>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
