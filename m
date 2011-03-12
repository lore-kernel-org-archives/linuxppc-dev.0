Return-Path: <diggskevin38@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0E38EB6FAF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Mar 2011 12:43:15 +1100 (EST)
Received: by iwc10 with SMTP id 10so3373099iwc.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Mar 2011 17:43:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56927.94.211.195.167.1299893950.squirrel@gate.crashing.org>
References: <AANLkTinfxdckX=sYk5fX4vRhnmJNTHnytWkUW0w_HMj4@mail.gmail.com>
	<56564.94.211.195.167.1299875156.squirrel@gate.crashing.org>
	<AANLkTinzpvV3Y7FXTPo8yPrE69CA1C1ejBMqC+O5o9zZ@mail.gmail.com>
	<56927.94.211.195.167.1299893950.squirrel@gate.crashing.org>
Date: Fri, 11 Mar 2011 19:43:12 -0600
Message-ID: <AANLkTikGEGTWzfETpzV982upPgxxkj1Em9VkJnakQbdb@mail.gmail.com>
Subject: Re: ongoing mesh saga ...
From: kevin diggs <diggskevin38@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Good to know. I just tried this on an x86 laptop. It was NOT happy!
And, obviously, I am not using a mesh SCSI controller on my Toshiba
A75.

And thanks again for your time!

kevin

On Fri, Mar 11, 2011 at 7:39 PM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>>> make drivers/scsi/mesh.s
>>>
>> ??? I thought I have tried this in the past and it did not work? The
>> make <path>/<file>.s thing?
>>
>> Thanks for the tip!
>
> You need to have the driver in your kernel config, or things will
> go weird.
>
>
> Segher
>
