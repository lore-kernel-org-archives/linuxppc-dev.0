Return-Path: <jwboyer@gmail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.187])
	by ozlabs.org (Postfix) with ESMTP id 12380DE530
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Sep 2008 01:25:48 +1000 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so575647rnf.16
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 Sep 2008 08:25:47 -0700 (PDT)
Date: Mon, 22 Sep 2008 11:24:44 -0400
From: Josh Boyer <jwboyer@gmail.com>
To: "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>
Subject: Re: Regarding select() on PPC
Message-ID: <20080922152444.GA9716@yoda.jdub.homelinux.org>
References: <7B7EF7F090B9804A830ACC82F2CDE95D56E0DA@insardxms01.ap.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7B7EF7F090B9804A830ACC82F2CDE95D56E0DA@insardxms01.ap.sony.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Sep 22, 2008 at 08:45:52PM +0530, Sadashiiv, Halesh wrote:
>
>
>The issue is found only in PPC32.
>
>Please let me if the patch is applicable.

Well, no not really.  Mostly because of procedural issues than anything
else.  Read Documentation/SubmittingPatches in the kernel directory.

Also, there is a comment above this function that eludes to some issues
with select on ppc32.  You might want to ask the overall PowerPC maintainer
if that issue still exits.

josh
