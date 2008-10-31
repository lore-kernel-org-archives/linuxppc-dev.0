Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.232])
	by ozlabs.org (Postfix) with ESMTP id 17496DDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Nov 2008 03:33:34 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so1251056rvb.9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 31 Oct 2008 09:33:32 -0700 (PDT)
Message-ID: <fa686aa40810310933v364b195fx3f84ede9d6fb7fa2@mail.gmail.com>
Date: Fri, 31 Oct 2008 10:33:32 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "saadia dhouib" <saadia_dhouib@yahoo.fr>
Subject: Re: Linux 2.6 boot failure on xup virtex II ppc405
In-Reply-To: <20269333.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20252128.post@talk.nabble.com> <20269333.post@talk.nabble.com>
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

On Fri, Oct 31, 2008 at 10:21 AM, saadia dhouib <saadia_dhouib@yahoo.fr> wrote:
>
> Hi all,
>
> After booting successfully the kernel without a root file system.
>
> I  installed a file system on the flash disk. I used: BusyBox 1.12.1, and
> the script mkrootfs.sh (written by
>
> Wofgang Klingauf) to generate the rfs.

Looks like you don't have the ext3 driver compiled into your kernel.

g.
