Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 61711DDEF8
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 01:56:20 +1000 (EST)
Message-ID: <4718D39C.1030707@freescale.com>
Date: Fri, 19 Oct 2007 10:56:12 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
Subject: Re: qe: add ability to upload QE firmware
References: <11927201051427-git-send-email-timur@freescale.com>
	<4717DEE8.9010508@gmail.com>
In-Reply-To: <4717DEE8.9010508@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jerry Van Baren wrote:

>> +/*
>> + * Download a microcode to the I-RAM at a specific address.
>       ^^^^^^^^
>> + *
>> + * @firmware: pointer to qe_firmware structure
>> + */
>> +int qe_upload_microcode(const struct qe_firmware *firmware)
>           ^^^^^^
> We seem to be a little conflicted over whether it is an upload or a 
> download.  ;-)

Oh, now I see what you're talking about.  Duh.
