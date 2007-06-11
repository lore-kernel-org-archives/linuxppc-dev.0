Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.224])
	by ozlabs.org (Postfix) with ESMTP id 792FFDDEC4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Jun 2007 02:06:26 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id v1so1228001nzb
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Jun 2007 09:06:24 -0700 (PDT)
Message-ID: <fa686aa40706110906p2de5c4e3i108d67dc1fd411de@mail.gmail.com>
Date: Mon, 11 Jun 2007 10:06:23 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: a question for linux framebuffer driver
In-Reply-To: <20070611160313.B1A36DA8056@mail207-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <1316548361.5052161181391690811.JavaMail.coremail@bj163app129.163.com>
	<20070611160313.B1A36DA8056@mail207-sin.bigfish.com>
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

On 6/11/07, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> wrote:
>
> The kernel has to be informed of the device itself using platform_device_register.
> I believe in the kernel you have you'll have to add code to do this, and
> /arch/ppc/platforms/4xx/virtex.c is a reasonable place.

In more recent kernels, look at arch/ppc/syslib/virtex_devices.c

g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
