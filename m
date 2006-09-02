Return-Path: <jonscully@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.179])
	by ozlabs.org (Postfix) with ESMTP id B180667BA2
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  3 Sep 2006 09:47:17 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id f28so1686364pyf
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 02 Sep 2006 16:47:15 -0700 (PDT)
Message-ID: <53107f6e0609021647l1f1cd84du496e3cd7219b603@mail.gmail.com>
Date: Sat, 2 Sep 2006 16:47:15 -0700
From: "Jon Scully" <jonscully@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8245 reset register
In-Reply-To: <198592450609021546x57c71e48r9aed561b61f6e8aa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <198592450609021546x57c71e48r9aed561b61f6e8aa@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/2/06, Reeve Yang <yang.reeve@gmail.com> wrote:
> Can anyone tell me which register should I use to do soft reset on MPC8241/5
> CPU? I searched its manuall but only find EPIC to send SRESET exception on
> offset 0x41090.
>
>  Thanks.
>
>  - Reeve
>

Use the reset instruction (RST in assembly).
