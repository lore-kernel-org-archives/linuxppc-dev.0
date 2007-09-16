Return-Path: <jeff@mock.com>
Received: from mail.mock.com (gw.mock.com [209.157.146.194])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.mock.com", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 486B1DDE08
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Sep 2007 05:09:58 +1000 (EST)
Message-ID: <46ED78F8.70506@mock.com>
Date: Sun, 16 Sep 2007 11:42:00 -0700
From: Jeff Mock <jeff@mock.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Domen's MPC5200 FEC cleanup patch.
References: <9e4733910709142038y1bd88cd5s7c9bb21a668db9f6@mail.gmail.com>	<9e4733910709142128l7a264a05ve68f59aee92b40e3@mail.gmail.com>	<20070915122218.GB19857@nd47.coderock.org>	<9e4733910709150855k6ba6dc8fye9762817566208b4@mail.gmail.com>	<9e4733910709161000i64622520i77caa00e56abc7a8@mail.gmail.com>	<9e4733910709161005u4f400ab7wb1bf55dac1b45193@mail.gmail.com>	<9e4733910709161100i456c176ay664d89ac638c9958@mail.gmail.com>
	<9e4733910709161125u15dcd02cj300c0e3a7fda4c0a@mail.gmail.com>
In-Reply-To: <9e4733910709161125u15dcd02cj300c0e3a7fda4c0a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Domen Puncer <domen.puncer@telargo.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Jon Smirl wrote:
> On 9/16/07, Jon Smirl <jonsmirl@gmail.com> wrote:
>> Another problem...
>>
>> Ifconfig eth0 down
>>
>> hangs the system.
>> I'll try debugging it.
> 
> The hang is something to do with lockd in NFS, it doesn't appear to
> have anything to do with fec. I think I need to build more of NFS into
> my kernel.
> 

I think the NFS hang has something to do with not having a copy of 
portmap running.  I've had this happen with other embedded systems, and 
can usually work around it by using the "-o nolock" option when doing 
the NFS mount.

jeff
