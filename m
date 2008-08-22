Return-Path: <jwboyer@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.235])
	by ozlabs.org (Postfix) with ESMTP id D34CBDE081
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Aug 2008 23:25:32 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id c48so385542wra.1
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Aug 2008 06:25:31 -0700 (PDT)
Date: Fri, 22 Aug 2008 09:24:55 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: vb <vb@vsbe.com>
Subject: Re: TLB programming in powerpc tree. Was: Accessing peripheral bus
	devices on 460GT
Message-ID: <20080822132455.GD22283@yoda.jdub.homelinux.org>
References: <f608b67d0808211929g3ae2cf7dm2ba2d65b0043d306@mail.gmail.com>
	<f608b67d0808212214p3c3e008fxa5418d108b7205f5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f608b67d0808212214p3c3e008fxa5418d108b7205f5@mail.gmail.com>
Sender: Josh Boyer <jwboyer@gmail.com>
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

On Thu, Aug 21, 2008 at 10:14:15PM -0700, vb wrote:
>On Thu, Aug 21, 2008 at 7:29 PM, vb <vb@vsbe.com> wrote:
>>
>> But the main problem is that the kernel never sets up TLBs for neither
>> the peripheral device, nor the onboard flash. I don't seem to be able
>> to find the place where this is supposed to happen. I assumed that
>> ioremap_nocache would take care of that, but this is not the case.
>>
>
>well, in fact the TLB is set up as soon as an attempt to access the
>peripheral is made. The problem apparently is the fact that the TLB
>entry uses a wrong value in the nibble specifying the internal 460GT
>block...

I'm not entirely sure what you mean here.  Can you elaborate a bit more?

josh
