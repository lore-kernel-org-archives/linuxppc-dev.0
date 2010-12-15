Return-Path: <tmarri@apm.com>
Received: from exprod5og111.obsmtp.com (exprod5og111.obsmtp.com [64.18.0.22])
	by ozlabs.org (Postfix) with SMTP id 88CF6B7082
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Dec 2010 09:50:27 +1100 (EST)
Received: by qyk36 with SMTP id 36so2556734qyk.20
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Dec 2010 14:50:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTikOituTX-gTQrr7cr2bXdbvf=A2UqHX0yVf8UDP@mail.gmail.com>
References: <1291854539-23879-1-git-send-email-tmarri@apm.com>
	<20101210224402.GA8943@kroah.com>
	<AANLkTinE1sPt4YQJGgW7-RHOsA8vF9HB-joSuryYFXpi@mail.gmail.com>
	<AANLkTikOituTX-gTQrr7cr2bXdbvf=A2UqHX0yVf8UDP@mail.gmail.com>
Date: Wed, 15 Dec 2010 14:50:20 -0800
Message-ID: <AANLkTim4nh-9mL=ziAKbcRa2kZnoQk0pinREZ0qMYuqN@mail.gmail.com>
Subject: Re: [PATCH V6 00/10] Add-Synopsys-DesignWare-HS-USB-OTG-driver
From: Tirumala Marri <tmarri@apm.com>
To: Neil Jones <neiljay@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 15, 2010 at 2:17 AM, Neil Jones <neiljay@gmail.com> wrote:
> Hi,
>
> I've looked at the patches but your email states there are 10 patches,
> I can't see #1 and #10, only 2- 8 ??
>
> It doesn't look like you have resolved the lockdep issues we have been
> seeing, please get in contact as it
> would be good to discuss our issues with this driver ( and our distain
> for Synopsis ;-) ).
>
> Cheers
>
> Neil
>
> On Mon, Dec 13, 2010 at 3:48 PM, Neil Jones <neiljay@gmail.com> wrote:
>> Hi,
>>
>> We are currently using the latest version of this Synopsis IP in some
>> of our customers SoC's.
>>
>> The latest hardware adds a new DMA mode which is less Interrupt
>> intensive as well as a few other features.
>>
>> I have spent (and im still spending) a long time fixing up this driver
>> to be linux standards compliant with the intention of pushing it
>> upstream once complete, its still not ready yet.
>>
>> One of the major issues we had is the driver isn't SMP safe, I've not
>> had chance to review your patches yet but have your run the driver
>> with lock checking turned on ?
>>
>> Would it be possible to get the changes for the latest version of the
>> IP merged into this driver, I can supply my current version as a
>> reference.
>>
>> In my driver :
>>
>> Currently host support is working well and i've tested it with
>> multiple devices and done the test outlined on
>> http://www.linux-usb.org/usbtest/, the driver passed checkpatches and
>> runs with lockdeps on and on a SMP system, Im still working on the
>> device mode (PCD) part of the driver generally it works, but im still
>> getting the odd lock dep warning and a panic on un-loading of certain
>> gadget kernel modules. The only issue with our driver is I have not
>> converted all the bitfield usage to macros so it might make diffing a
>> pain.
>>
>> Cheers
>>
>> Neil
Hi,
  Sorry for the late reply, I was busy working on the patch. Idea is to
functional patch for PPC architecture initially and extend that to SMP
and resolve other bugs if there at all. To push all the features in
one go is kind
of hard and increases the size of patches.

 Sure let us discuss further if there are know issues need to be resolved
in the driver.

Thanks,
Marri
