Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by ozlabs.org (Postfix) with ESMTP id 42858DDE0F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Sep 2007 01:00:58 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so3004001wag
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Sep 2007 08:00:57 -0700 (PDT)
Message-ID: <fa686aa40709260800o49cc9816j642358a14731d08f@mail.gmail.com>
Date: Wed, 26 Sep 2007 09:00:51 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Mead, Joseph" <mead@bnl.gov>
Subject: Re: git files from secret lab
In-Reply-To: <D1AFFAE2CC4BD54CA4C1543CFF4A4FCC5972C9@exchangemb3.bnl.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4e5a3720709260725x6d2e9faemc6a6053379610df8@mail.gmail.com>
	<D1AFFAE2CC4BD54CA4C1543CFF4A4FCC5972C9@exchangemb3.bnl.gov>
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

On 9/26/07, Mead, Joseph <mead@bnl.gov> wrote:
> Hi,
>
> I'm trying to download the xilinx patches from  Grant's git repository,
> but don't quite understand what I am doing.
>
> I cloned the tree from Linus' tree
>
> git clone
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> (this worked fine)
>
> cd linux-2.6

What version of git are you running (git --version).  That tree is
using the virtual hosting feature of newer versions of git.  You need
to be running at least version 1.5.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
