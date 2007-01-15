Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id C3627DDE41
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Jan 2007 00:50:13 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1298039ugf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 15 Jan 2007 05:50:11 -0800 (PST)
Message-ID: <528646bc0701150550s4cc79165o7670bdf478c0af2e@mail.gmail.com>
Date: Mon, 15 Jan 2007 06:50:11 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "David Gamez" <dgalari@gmail.com>
Subject: Re: flash problem in a LITE5200B
In-Reply-To: <3184691b0701150249g55d2472ax583acca96f0efb30@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <3184691b0701150249g55d2472ax583acca96f0efb30@mail.gmail.com>
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

On 1/15/07, David Gamez <dgalari@gmail.com> wrote:
> Hi all,
>
> I work with a Freescale LITE5200B, but I have a problem, when I download a
> rootfs image to a flash memory in the board, hi have one error:
>
> => Copy To Flash ............. Outside available Flash
>
> The size of the image is of 3285336 bytes, but the flash memory capacity is
> 32 MBytes, and I load the image in the first sector on the flash memory.

Please post your full boot log from power on to the error message.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
