Return-Path: <adgospod@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.229])
	by ozlabs.org (Postfix) with ESMTP id BAB1ADDF30
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Apr 2007 23:46:03 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so1251031nzf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 09 Apr 2007 06:46:02 -0700 (PDT)
Message-ID: <bdfc5d6e0704090646m7e3b1b65o53cef605fcfbf4ee@mail.gmail.com>
Date: Mon, 9 Apr 2007 09:46:00 -0400
From: "Andy Gospodarek" <andy@greyhouse.net>
Sender: adgospod@gmail.com
To: "Ashish Ranjan Dash" <ADash@alphion.com>
Subject: Re: MPC8245 Broadcom BMW board
In-Reply-To: <8584FDC94AFF7640B17B8A89B23B19B388F176@sbsserver.AlphionCorp.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <8584FDC94AFF7640B17B8A89B23B19B388F176@sbsserver.AlphionCorp.local>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I would recommend u-boot.  You can probably boot CFE if you want, but
I found u-boot to be better.  I've used that board quite a bit in the
past and mostly booted u-boot/linux using the 2MB flash instead of the
512MB one.  You will want to make sure you have some kind of flash
programmer before  you start wiping out what is on there, but once you
get that working you should be fine.

On 4/9/07, Ashish Ranjan Dash <ADash@alphion.com> wrote:
>
>
> Hi,
>
> I need some help in booting linux on broadcom bmw( MPC8245 - KAHLUA2)board.
> The board has the vxWork boot loader, can i boot linux with this boot
> loader?
>
> Should I go for CFE provided by Broacom. or
> Should I go for u-boot as it supports my board.
> Please tell me about shadow flasing so that I can have a headstart.
>
> Thanks and Regards,
>
> Aashis
>
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
