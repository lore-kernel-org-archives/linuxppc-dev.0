Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id 8DBC167BE6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Sep 2006 01:56:08 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so593239ugc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Sep 2006 08:56:07 -0700 (PDT)
Message-ID: <528646bc0609260856y69339eb2nb237e53efc2d6de5@mail.gmail.com>
Date: Tue, 26 Sep 2006 09:56:06 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Mohan Krishna T" <tmk@cmcltd.com>
Subject: Re: Unable to boot linux on Xilinx ML403 board
In-Reply-To: <7225230023970127285@unknownmsgid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <528646bc0609260638t16dae54ct266548030e21ffd1@mail.gmail.com>
	<7225230023970127285@unknownmsgid>
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

On 9/26/06, Mohan Krishna T <tmk@cmcltd.com> wrote:
> The zImage.initrd.elf is of size 3.4MB. I am getting hanged only when I am
> using DMA for Ethernet. Booting is going fine when I am using FIFO Mode.

You may be hitting the 4MB upper limit for zImages.  I had the same
problem with slightly smaller images, and it would hang at (seemingly)
random places everytime I changed something.  Making the image smaller
made the problem go away.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
