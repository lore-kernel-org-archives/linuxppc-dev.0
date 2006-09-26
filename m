Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id E46C067B6A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Sep 2006 23:38:58 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so577550ugc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Sep 2006 06:38:56 -0700 (PDT)
Message-ID: <528646bc0609260638t16dae54ct266548030e21ffd1@mail.gmail.com>
Date: Tue, 26 Sep 2006 07:38:55 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Mohan Krishna T" <tmk@cmcltd.com>
Subject: Re: Unable to boot linux on Xilinx ML403 board
In-Reply-To: <7340827822720465792@unknownmsgid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <451800D9.5010702@xilinx.com> <7340827822720465792@unknownmsgid>
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
> I have tried the option you have suggested but couldn't boot successfully. I
> tried to debug where exactly the kernel is getting hanged. I could found
> that its hanging in gunzip() function call. It is never coming out of loop
> that decompress the ramdisk image.

How large is you zImage.embedded?

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
