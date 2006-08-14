Return-Path: <adgospod@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by ozlabs.org (Postfix) with ESMTP id 9F696679E9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Aug 2006 03:25:32 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id c29so17569nfb
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Aug 2006 10:24:33 -0700 (PDT)
Message-ID: <bdfc5d6e0608141024j7f12b0fcy2e1b9f2b2dc4c1dd@mail.gmail.com>
Date: Mon, 14 Aug 2006 13:24:32 -0400
From: "Andy Gospodarek" <andy@greyhouse.net>
Sender: adgospod@gmail.com
To: "Guy Streeter" <streeter@redhat.com>
Subject: Re: Can red hat linux be ported to Power PC ???????????????
In-Reply-To: <1155575895.4044.6.camel@mentos.hsv.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <b47d45990608140956s1a1dcdbbh8b454d0fe487a271@mail.gmail.com>
	<1155575895.4044.6.camel@mentos.hsv.redhat.com>
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

On 8/14/06, Guy Streeter <streeter@redhat.com> wrote:
> On Mon, 2006-08-14 at 22:26 +0530, Ujwal wrote:
> > hi all,
> >
> > can red hat linux(2.4 kernel with a the .config file of ML310 board )
> > be ported to PowerPC on a development board?
>
> The ppc arch of the kernel tree was not well maintained in the Red Hat
> kernel source for the release that used the 2.4 kernel (Red Hat
> Enterprise Linux 3).
> I would be surprised if it built, and I'm fairly certain it would not
> run.
>
> That being said, Red Hat makes a business in developing its products for
> other platforms and might consider the work on a contract basis.
>
> --Guy Streeter
>
>

Is there a particular reason to use a RedHat kernel?

I would suggest using the ELDK (from denx.de) if you are looking for a
stable kernel on which to base your product/project.

-andy
