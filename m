Return-Path: <timur.tabi@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.224])
	by ozlabs.org (Postfix) with ESMTP id 68587DE3AA
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Aug 2008 01:17:35 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id c48so1083970wra.1
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 08:17:33 -0700 (PDT)
Message-ID: <ed82fe3e0808150817k66d6c70fp17774fbd726ea2b2@mail.gmail.com>
Date: Fri, 15 Aug 2008 10:17:31 -0500
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: "Jon Loeliger" <jdl@jdl.com>, devicetree-discuss@ozlabs.org,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V2] DTC: Remove support for the legacy DTS source file
	format.
In-Reply-To: <20080815002936.GA9877@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <E1KTlq7-0005Gh-Co@jdl.com> <20080815002936.GA9877@yookeroo.seuss>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 14, 2008 at 7:29 PM, David Gibson
<david@gibson.dropbear.id.au> wrote:
> On Thu, Aug 14, 2008 at 06:02:43PM -0500, Jon Loeliger wrote:
>> Now that all in-kernel-tree DTS files are properly /dts-v1/,
>> remove direct support for the older, un-numbered DTS
>> source file format.
>
> Um.. why?  I just don't see a compelling reason to remove this
> backwards compatibility.  It costs us very little to keep it around
> indefinitely.

I agree, why are we removing backwards compatibility?  The dts-v1
format isn't that old, so I'm sure there are plenty of device trees
out there, especially on our BSPs, that haven't been updated yet.

How about just printing a warning and saying that the device tree
should be updated with the conversion tool?

-- 
Timur Tabi
Linux kernel developer at Freescale
