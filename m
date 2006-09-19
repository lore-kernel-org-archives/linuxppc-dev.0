Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id 348CB67B5E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Sep 2006 00:16:12 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so459940ugc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Sep 2006 07:16:11 -0700 (PDT)
Message-ID: <528646bc0609190716q4a18f769g43ef2446b0844a27@mail.gmail.com>
Date: Tue, 19 Sep 2006 08:16:10 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "John Bonesio" <john.bonesio@xilinx.com>
Subject: Re: Ethernet driver for Linux kernel 2.6 running on ML403
In-Reply-To: <2FE3DBF1797A1443AAB3FA0EF6BF4EEC021EAC01@XSJ-EXCHVS1.xlnx.xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <2FE3DBF1797A1443AAB3FA0EF6BF4EEC021EAC01@XSJ-EXCHVS1.xlnx.xilinx.com>
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

[edited for context]

On 9/15/06, John Bonesio <john.bonesio@xilinx.com> wrote:
> On Thursday, September 14, 2006 5:09 PM, Keith J Outwater wrote:
> > I thinking in terms of something like a 32 bit register (i.e. like a
> > processor's PVR register) that has a hard-coded magic number
> > which a driver can read and decode to determine driver compatibility.
> > That does not sound resource-intensive given the size FPGAs we are
> > talking about.  Probably don't even need 32 bits.
>
> I know that on the surface it seems like a simple thing. Some of our
> parts are big, yet some are small. We are always getting pressure to
> make our IP as small as possible.
>
> Though, this may be something we can revisit again, for now this
> information just isn't going to be available.

Then its probably just a matter of whoever configures the kernel needs
to know what version of IP is being used.  ie. always have the
fallback of compile time specification of IP version. Could be done
manually, or by putting the info into the dts.  We probably need a
tool to generate a dts from the .mhs or xparameters.h file anyway.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
