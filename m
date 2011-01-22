Return-Path: <diggskevin38@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A4B72B7101
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 22 Jan 2011 13:03:06 +1100 (EST)
Received: by iwb12 with SMTP id 12so2513859iwb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Jan 2011 18:03:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1295661056.2148.334.camel@pasglop>
References: <AANLkTikAVgH9-UQfrjoAJSemet5p_PxhxCdot8cChQu3@mail.gmail.com>
	<1295644908.2148.309.camel@pasglop>
	<AANLkTi=CVNC-UjdCyByyey_VnPHGtujuH01tquSQyqRm@mail.gmail.com>
	<1295661056.2148.334.camel@pasglop>
Date: Fri, 21 Jan 2011 20:03:02 -0600
Message-ID: <AANLkTikitgJYiALMRmtKQTs_eYgzGbZpeMkpg2M478cj@mail.gmail.com>
Subject: Re: BootX
From: kevin diggs <diggskevin38@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
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

The link:

http://www.shiner.info/?files/Yellow%20Dog%20Linux%204/quik

to download the latest source does not seem to have anything useful???

kevin

On Fri, Jan 21, 2011 at 7:50 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2011-01-21 at 19:48 -0600, kevin diggs wrote:
>> Hi,
>>
>> This would require quik, right? I went to penguinppc.org and tried to
>> get the latest BootX and quik but the links are dead. Do you know
>> where the latest versions are?
>
> That link still works:
>
> Oops... typing FAIL :-)
>
> I meant:
>
> http://penguinppc.org/bootloaders/quik/
>
> However, it's possible that distros like debian have done more changes to it.
>
> Another option is to netboot a zImage directly, which works if it's not
> too big.
>
> Cheers,
> Ben.
>
>> kevin
>>
>> On Fri, Jan 21, 2011 at 3:21 PM, Benjamin Herrenschmidt
>> <benh@kernel.crashing.org> wrote:
>> > On Fri, 2011-01-21 at 13:26 -0600, kevin diggs wrote:
>> >> Hi,
>> >>
>> >> Anyone familiar with BootX? Could my problems with the 8600 be related
>> >> to some interaction with BootX?
>> >
>> > It's possible. Have you tried using OF booting instead ? The 8600 should
>> > be cable to boot off SCSI or netboot COFF images.
>> >
>> > Cheers,
>> > Ben.
>> >
>> >
>
>
>
>
