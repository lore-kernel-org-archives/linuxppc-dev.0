Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id 5C1E6DDD04
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  2 Dec 2007 15:30:47 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so543544anc
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 01 Dec 2007 20:30:46 -0800 (PST)
Message-ID: <fa686aa40712012030r6ca993aek5dd4e58c961ac6fb@mail.gmail.com>
Date: Sat, 1 Dec 2007 21:30:45 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "narendra sisodiya" <narendra.sisodiya@gmail.com>
Subject: Re: Linux 2.4 on ML310 with PowerPC405
In-Reply-To: <e3fb97f30712010459y1e15f593i58381ba81487960a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e3fb97f30712010459y1e15f593i58381ba81487960a@mail.gmail.com>
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

On 12/1/07, narendra sisodiya <narendra.sisodiya@gmail.com> wrote:
> Hi all,
> I am trying to port Linux on ML310 virtex 2 pro,,
> I am unable to compile my properly,,,
> here i documented my procedure,,,
> http://placements.techfandu.org/index.php?title=Linux_kernel_on_ML310
>
> Please check out ,, where i am doing mistake

I'm sorry, but I don't understand where you are having your problems.
Specifically, what error are you getting when your kernel fails to
compile?

As for the kernel version, I do not recommend using linux 2.4 any
more.  You should consider using a 2.6 kernel instead.  I've got some
documentation on the 2.6 kernel for virtex devices here:

http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
